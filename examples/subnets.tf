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
  name                 = "devcc-mid"
  resource_group_name  = "network-dev-rg"
  virtual_network_name = "devcc-vnet"
}

module "mssql" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql?ref=v3.1.0"

  mssql_name          = "sqlservername001"
  location            = "canadacentral"
  environment         = "dev"
  resource_group_name = "hosting-sql-dev-rg"

  administrator_login                           = ""
  administrator_login_password                  = ""
  active_directory_administrator_login_username = ""
  active_directory_administrator_object_id      = ""
  active_directory_administrator_tenant_id      = ""

  kv_enable              = true
  kv_name                = "hostingops-sql-dev-kv"
  kv_resource_group_name = "hostingops-sql-dev-rg"
  sa_resource_group_name = "hostingops-sql-dev-rg"

  #Database Configurations
  db_names = {
    "anydb" = { sku = "GP_S_Gen5_2" }
  }
  db_owners = ["HostingDevSQL"] #Your AD Group or cloud username @cloud.statcan.ca

  #[Optional] Private Endpoint Configurations
  private_endpoints = {
    "pe-container" = { subnet_id = data.azurerm_subnet.container.id, private_dns_zone_ids = [data.azurerm_private_dns_zone.mssql.id] }
    "pe-back"      = { subnet_id = data.azurerm_subnet.back.id, private_dns_zone_ids = [data.azurerm_private_dns_zone.mssql.id] }
    "pe-front"     = { subnet_id = data.azurerm_subnet.front.id, private_dns_zone_ids = [data.azurerm_private_dns_zone.mssql.id] }
    "pe-mid"       = { subnet_id = data.azurerm_subnet.mid.id, private_dns_zone_ids = [data.azurerm_private_dns_zone.mssql.id] }
  }

  #[Optional] Elastic Pool Configurations
  # ep_names = {
  #   "standard_dev_pool_01" = { max_size_gb = 4.8828125, sku = "BasicPool", tier = "Basic", capacity = 50, max_capacity = 5, min_capacity = 0}
  # }

  #[Optional] Configurations 
  #emails                                        = ["first.lastname@statcan.gc.ca"]
  #mssql_version                                 = "12.0"
  #retention_days                                = 90
  #job_agent_credentials                         = { username = "username", password = "password" }
  #express_va_enabled                            = ttrue

  #[Optional] Firewall Configurations
  firewall_rules = ["0.0.0.0"]
  subnets        = [data.azurerm_subnet.container, data.azurerm_subnet.back, data.azurerm_subnet.front, data.azurerm_subnet.mid]
  #ssl_minimal_tls_version_enforced              = "1.2"
  #connection_policy                             = "Default"

  #[Optional] User Assigned Managed Identity Configurations
  #primary_mi_id                                 = "abcdefg1234567"

  tags = {
    "tier" = "k8s"
  }
}