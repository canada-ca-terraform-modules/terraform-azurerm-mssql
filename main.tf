module "sqlserver" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-server.git?ref=v1.1.4"

  count = var.module_server_count

  name                                          = var.name
  environment                                   = var.environment
  location                                      = var.location
  resource_group                                = var.rg
  dependencies                                  = []
  mssql_version                                 = var.mssql_version
  list_of_subnets                               = var.list_of_subnets
  ssl_minimal_tls_version_enforced              = "1.2"
  connection_policy                             = var.connection_policy
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
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-database.git?ref=v1.0.2"

  count                                  = length(var.database_names)

  name                                   = var.database_names[count.index].name
  collation                              = lookup(var.database_names[count.index], "collation", "SQL_Latin1_General_CP1_CI_AS")
  max_size_gb                            = lookup(var.database_names[count.index], "db_max_size_gb", null)
  short_retentiondays                    = lookup(var.database_names[count.index], "short_retentiondays", "7")
  ltr_monthly_retention                  = lookup(var.database_names[count.index], "ltr_monthly_retention", null)
  ltr_week_of_year                       = lookup(var.database_names[count.index], "ltr_week_of_year", "52")
  ltr_weekly_retention                   = lookup(var.database_names[count.index], "ltr_weekly_retention", "P1W")
  ltr_yearly_retention                   = lookup(var.database_names[count.index], "ltr_yearly_retention", null)

  environment                            = var.environment
  server_id                              = module.sqlserver[0].id
  server_name                            = module.sqlserver[0].name
  sku_name                               = var.db_sku_names[count.index]
  dbowner                                = var.dbowner
  kv_name                                = var.kv_name
  kv_rg                                  = var.kv_rg
  storageaccountinfo_resource_group_name = var.storageaccountinfo_resource_group_name
  tags                                   = var.tags

  sa_primary_blob_endpoint = module.sqlserver[0].sa_primary_blob_endpoint
  sa_primary_access_key    = module.sqlserver[0].sa_primary_access_key
}

module "elasticpool" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-elasticpool.git?ref=v1.0.1"

  count = var.module_elasticpool_count

  name                = var.name
  location            = var.location
  resource_group_name = var.rg
  server_name         = module.sqlserver[0].name
  max_size_gb         = var.max_size_gb
  sku_name            = var.pool_sku_name
  tier                = var.tier
  family              = var.family
  capacity            = 40
  min_capacity        = 2
  max_capacity        = 4
}
