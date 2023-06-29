data "azurerm_private_dns_zone" "mssql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = "network-management-rg"
  provider            = azurerm.mgmt
}

data "azurerm_subnet" "container" {
  name                 = "devcc-container"
  resource_group_name  = "network-dev-rg"
  virtual_network_name = "devcc-vnet"
}

data "azurerm_subnet" "back" {
  name                 = "devcc-back"
  resource_group_name  = "network-dev-rg"
  virtual_network_name = "devcc-vnet"
}

data "azurerm_subnet" "front" {
  name                 = "devcc-front"
  resource_group_name  = "network-dev-rg"
  virtual_network_name = "devcc-vnet"
}

data "azurerm_subnet" "mid" {
  name                = "devcc-mid"
  resource_group_name = "network-dev-rg"
}

module "mssql" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql?ref=v2.0.4"

  mssql_name          = "sqlservername001"
  location            = "canadacentral"
  environment         = "dev"
  resource_group_name = "hosting-sql-dev-rg"

  db_names = {
    "anydb" = { sku = "GP_S_Gen5_2" }
  }

  db_owners = ["HostingDevSQL"] #Your AD Group or email

  administrator_login                           = ""
  administrator_login_password                  = ""
  active_directory_administrator_login_username = ""
  active_directory_administrator_object_id      = ""
  active_directory_administrator_tenant_id      = ""

  kv_enable              = true
  kv_name                = "hostingops-sql-dev-kv"
  kv_resource_group_name = "hostingops-sql-dev-rg"
  sa_resource_group_name = "hostingops-sql-dev-rg"


  #[Optional] Configurations 
  #emails                                        = ["first.lastname@statcan.gc.ca"]
  #mssql_version                                 = "12.0"
  #retention_days                                = 90
  #job_agent_credentials                         = { username = "username", password = "password" }

  #[Optional] Elastic Pool Configurations
  /*ep_names = [
    { name = "standard_dev_pool_01", max_size_gb = 4.8828125, sku = "BasicPool", tier = "Basic", capacity = 50, max_capacity = 5, min_capacity = 0}
  ]*/

  #[Optional] Firewall Configurations
  firewall_rules = []
  subnets        = [data.azurerm_subnet.container, data.azurerm_subnet.back, data.azurerm_subnet.front, data.azurerm_subnet.mid]
  #ssl_minimal_tls_version_enforced              = "1.2"
  #connection_policy                             = "Default"

  #[Optional] User Assigned Managed Identity Configurations
  #primary_mi_id                                 = "abcdefg1234567"

  #Private Endpoint Configurations
  private_endpoint_subnet_id = [data.azurerm_subnet.back.id]
  private_dns_zone_ids       = [data.azurerm_private_dns_zone.mssql.id]

  tags = {
    "tier" = "k8s"
  }
}