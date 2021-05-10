module "sqlserver" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-server.git?ref=v1.0.0"

  name                                          = var.name
  environment                                   = var.environment
  location                                      = var.location
  resource_group                                = var.rg
  count                                         = var.module_server_count
  dependencies                                  = []
  mssql_version                                 = var.mssql_version
  list_of_subnets                               = []
  ssl_minimal_tls_version_enforced              = "1.2"
  firewall_rules                                = []
  kv_name                                       = var.kv_name
  kv_rg                                         = var.kv_rg
  storageaccountinfo_resource_group_name        = var.storageaccountinfo_resource_group_name
  administrator_login                           = var.administrator_login
  active_directory_administrator_login_username = var.active_directory_administrator_login_username
  active_directory_administrator_object_id      = var.active_directory_administrator_object_id
  active_directory_administrator_tenant_id      = var.active_directory_administrator_tenant_id
  emails                                        = var.emails
}

module "db" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-database.git?ref=v1.0.0"

  name                                   = var.name
  environment                            = var.environment
  count                                  = var.module_db_count
  server_id                              = module.sqlserver[count.index].id
  server_name                            = module.sqlserver[count.index].name
  dbowner                                = var.dbowner
  kv_name                                = var.kv_name
  kv_rg                                  = var.kv_rg
  storageaccountinfo_resource_group_name = var.storageaccountinfo_resource_group_name
  tags                                   = var.tags
}

module "elasticpool" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-elasticpool.git?ref=v1.0.0"

  name                = var.name
  location            = var.location
  resource_group_name = var.rg
  count               = var.module_elasticpool_count
  server_name         = module.sqlserver[count.index].name
  max_size_gb         = var.max_size_gb
  skuname             = "BasicPool"
  tier                = "Basic"
  capacity            = 100
  min_capacity        = 0
  max_capacity        = 5
}
