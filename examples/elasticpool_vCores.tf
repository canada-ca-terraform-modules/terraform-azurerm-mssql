data "azurerm_subnet" "devcc-back" {
  name                 = "devcc-back"
  virtual_network_name = "devcc-vnet"
  resource_group_name  = "network-dev-rg"
}

data "azurerm_private_dns_zone" "mssql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = "network-management-rg"
  provider            = azurerm.mgmt
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
    "elasticpoolbasic"      = { sku = "ElasticPool", elasticpool = "vcorepool001" }
    "elasticpoolallconfigs" = { sku = "ElasticPool", elasticpool = "vcorepool002", collation = "SQL_Latin1_General_CP1_CI_AS", max_size_gb = 32, min_capacity = 0.5, str_days = 7, ltr_monthly_retention = "P1Y", ltr_weekly_retention = "P1W", ltr_yearly_retention = "P1Y", ltr_week_of_year = "52" }
    "poollessbasic"         = { sku = "GP_Gen5_2" }
  }
  db_owners = ["HostingDevSQL"] #Your AD Group or cloud username @cloud.statcan.ca

  #[Optional] Private Endpoint Configurations
  # private_endpoints = {
  #   "pe-backcc" = { subnet_id = data.azurerm_subnet.devcc-back.id, private_dns_zone_ids = [data.azurerm_private_dns_zone.mssql.id] }
  # }

  #[Optional] Elastic Pool Configurations
  ep_names = {
    "vcorepool001" = { max_size_gb = 120, sku = "GP_Gen5", tier = "GeneralPurpose", capacity = 2, max_capacity = 2, min_capacity = 0.25, family = "Gen5" }
    "vcorepool002" = { max_size_gb = 120, sku = "GP_Gen5", tier = "GeneralPurpose", capacity = 2, max_capacity = 2, min_capacity = 0.25, family = "Gen5" }
  }

  #[Optional] Configurations 
  #emails                                        = ["first.lastname@statcan.gc.ca"]
  #mssql_version                                 = "12.0"
  #retention_days                                = 90
  #job_agent_credentials                         = { username = "username", password = "password" }
  #express_va_enabled                            = ttrue

  #[Optional] Firewall Configurations
  #firewall_rules                                = []
  #subnets                                       = [data.azurerm_subnet.devcc-back.id]
  #ssl_minimal_tls_version_enforced              = "1.2"
  #connection_policy                             = "Default"

  #[Optional] User Assigned Managed Identity Configurations
  #primary_mi_id                                 = "abcdefg1234567"

  tags = {
    "tier" = "k8s"
  }
}