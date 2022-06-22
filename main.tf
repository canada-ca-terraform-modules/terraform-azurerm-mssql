module "sqlserver" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-server.git?ref=v1.1.4"

  count = var.module_server_count

  name                                          = var.name
  environment                                   = var.environment
  location                                      = var.location
  resource_group                                = var.resource_group_name
  dependencies                                  = []
  mssql_version                                 = var.mssql_version
  list_of_subnets                               = var.list_of_subnets
  ssl_minimal_tls_version_enforced              = "1.2"
  connection_policy                             = var.connection_policy
  firewall_rules                                = var.firewall_rules
  kv_name                                       = var.kv_name
  kv_rg                                         = var.kv_resource_group_name
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

  name                                   =
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

  count = length(var.elasticpool_settings)

  name                = var.elasticpools[count.index].name
  location            = var.location
  resource_group_name = var.resource_group_name
  server_name         = module.sqlserver[0].name
  max_size_gb         = lookup(var.elasticpools[count.index], "max_size_gb", null)
  sku_name            = lookup(var.elasticpools[count.index], "pool_sku_name", null)
  tier                = lookup(var.elasticpools[count.index], "tier", null)
  family              = lookup(var.elasticpools[count.index], "family", null)
  capacity            = lookup(var.elasticpools[count.index], "capacity", null)
  min_capacity        = lookup(var.elasticpools[count.index], "min_capacity", null)
  max_capacity        = lookup(var.elasticpools[count.index], "max_capacity", null)
}
