module "mssql_example" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql.git?ref=v1.1.2"

  // GLOBALS
  name        = "mssqlservername"
  location    = "canadacentral"
  environment = "dev"
  rg          = "mssql-dev-rg"

  // SERVER
  module_server_count          = 1
  administrator_login          = "sqlhstsvc"
  administrator_login_password = var.administrator_login_password
  emails = [
    "william.hearn@canada.ca",
    "zachary.seguin@canada.ca"
  ]
  tags = {
    "tier" = "k8s"
  }
  mssql_version = "12.0"
  # keyvault_enable = true
  # kv_name = ""
  # kv_rg = ""
  # storageaccountinfo_resource_group_name = ""
  # active_directory_administrator_login_username = ""
  # active_directory_administrator_object_id = ""
  # active_directory_administrator_tenant_id = ""
  firewall_rules  = []
  list_of_subnets = [local.containerCCSubnetRef]

  // DB
  database_names = [
    { name = "mssqlservername", collation = "SQL_Latin1_General_CP437_CI_AI" }
  ]
  db_sku_name = "GP_Gen5_4"
  dbowner     = "firstname.lastname@cloud.statcan.ca"

  // POOL
  module_elasticpool_count = 1
  pool_sku_name            = "BasicPool"
  tier                     = "Basic"
  max_size_gb              = 9.7656250
}
