module "sqlserver" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-server.git?ref=master"

  count = var.module_server_count

  name                                          = var.name
  environment                                   = var.environment
  location                                      = var.location
  resource_group                                = var.rg
  dependencies                                  = []
  mssql_version                                 = var.mssql_version
  list_of_subnets                               = var.list_of_subnets
  ssl_minimal_tls_version_enforced              = "1.2"
  firewall_rules                                = var.firewall_rules
  kv_name                                       = var.kv_name
  kv_rg                                         = var.kv_rg
  storageaccountinfo_resource_group_name        = var.storageaccountinfo_resource_group_name
  administrator_login                           = var.administrator_login
  administrator_login_password                  = var.administrator_login_password
  active_directory_administrator_login_username = var.active_directory_administrator_login_username
  active_directory_administrator_object_id      = var.active_directory_administrator_object_id
  active_directory_administrator_tenant_id      = var.active_directory_administrator_tenant_id
  emails                                        = var.emails
  keyvault_enable                               = var.keyvault_enable
}

module "db" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-database.git?ref=master"

  count = length(var.database_names)

  name      = var.database_names[count.index].name
  collation = lookup(var.database_names[count.index], "collation", "SQL_Latin1_General_CP1_CI_AS")

  environment                            = var.environment
  server_id                              = module.sqlserver[count.index].id
  server_name                            = module.sqlserver[count.index].name
  sku_name                               = var.db_sku_name
  dbowner                                = var.dbowner
  kv_name                                = var.kv_name
  kv_rg                                  = var.kv_rg
  storageaccountinfo_resource_group_name = var.storageaccountinfo_resource_group_name
  tags                                   = var.tags

  sa_primary_blob_endpoint = module.sqlserver[count.index].sa_primary_blob_endpoint
  sa_primary_access_key    = module.sqlserver[count.index].sa_primary_access_key
}

module "elasticpool" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-elasticpool.git?ref=master"

  count = var.module_elasticpool_count

  name                = var.name
  location            = var.location
  resource_group_name = var.rg
  server_name         = module.sqlserver[count.index].name
  max_size_gb         = var.max_size_gb
  sku_name            = var.pool_sku_name
  tier                = var.tier
  capacity            = 100
  min_capacity        = 0
  max_capacity        = 5
}
