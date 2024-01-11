module "sqlserver" {
  #??source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-server?ref=v2.0.2"
  source = "git::https://gitlab.k8s.cloud.statcan.ca/managed-databases/single-server/terraform-azurerm-mssql-server.git?ref=v4_patch"

  count = var.mssql_name == null ? 0 : 1

  name                                          = var.mssql_name
  environment                                   = var.environment
  location                                      = var.location
  resource_group_name                           = var.resource_group_name
  mssql_version                                 = var.mssql_version
  subnets                                       = var.subnets
  ssl_minimal_tls_version_enforced              = "1.2"
  connection_policy                             = var.connection_policy
  firewall_rules                                = var.firewall_rules
  kv_name                                       = var.kv_name
  kv_rg                                         = var.kv_resource_group_name
  kv_enable                                     = var.kv_enable
  sa_resource_group_name                        = var.sa_resource_group_name
  administrator_login                           = var.administrator_login
  administrator_login_password                  = var.administrator_login_password
  active_directory_administrator_login_username = var.active_directory_administrator_login_username
  active_directory_administrator_object_id      = var.active_directory_administrator_object_id
  active_directory_administrator_tenant_id      = var.active_directory_administrator_tenant_id
  emails                                        = var.emails
  private_endpoints                             = var.private_endpoints
  tags                                          = var.tags
  primary_mi_id                                 = var.primary_mi_id
  account_replication_type                      = var.account_replication_type
  express_va_enabled                            = var.express_va_enabled
}

module "elasticpool" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-elasticpool.git?ref=v1.0.2"

  for_each = var.ep_names

  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  server_name         = module.sqlserver[0].name
  max_size_gb         = lookup(each.value, "max_size_gb", null)
  sku_name            = lookup(each.value, "sku", null)
  tier                = lookup(each.value, "tier", null)
  family              = lookup(each.value, "family", null)
  capacity            = lookup(each.value, "capacity", null)
  min_capacity        = lookup(each.value, "min_capacity", null)
  max_capacity        = lookup(each.value, "max_capacity", null)
  tags                = var.tags

  depends_on = [
    module.sqlserver
  ]
}

module "db" {
  source   = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-database.git?ref=v2.0.3"
  for_each = var.db_names

  name                = each.key
  resource_group_name = var.resource_group_name
  location            = var.location
  environment         = var.environment

  collation                   = lookup(each.value, "collation", "SQL_Latin1_General_CP1_CI_AS")
  max_size_gb                 = lookup(each.value, "db_max_size_gb", null)
  min_capacity                = lookup(each.value, "min_capacity", 0.5)
  auto_pause_delay_in_minutes = lookup(each.value, "auto_pause_delay_in_minutes", 0)
  read_replica_count          = lookup(each.value, "read_replica_count", 0)
  read_scale                  = lookup(each.value, "read_scale", null)
  zone_redundant              = lookup(each.value, "zone_redundant", null)
  str_days                    = lookup(each.value, "str_days", local.str_days)
  ltr_monthly_retention       = lookup(each.value, "ltr_monthly_retention", null)
  ltr_week_of_year            = lookup(each.value, "ltr_week_of_year", null)
  ltr_weekly_retention        = lookup(each.value, "ltr_weekly_retention", null)
  ltr_yearly_retention        = lookup(each.value, "ltr_yearly_retention", null)
  create_mode                 = lookup(each.value, "create_mode", "Default")
  creation_source_database_id = lookup(each.value, "creation_source_database_id", null)
  recover_database_id         = lookup(each.value, "recover_database_id", null)
  restore_dropped_database_id = lookup(each.value, "restore_dropped_database_id", null)
  restore_point_in_time       = lookup(each.value, "restore_point_in_time", null)
  sku                         = lookup(each.value, "sku", "Basic")

  server_id   = module.sqlserver[0].id
  server_name = module.sqlserver[0].name

  elastic_pool_id = lookup(each.value, "elasticpool", null) != null ? module.elasticpool[lookup(each.value, "elasticpool", "")].elasticpool.id : null

  kv_name = var.kv_name
  kv_rg   = var.kv_resource_group_name

  sa_resource_group_name   = var.sa_resource_group_name
  sa_primary_blob_endpoint = module.sqlserver[0].sa_primary_blob_endpoint
  sa_primary_access_key    = module.sqlserver[0].sa_primary_access_key

  job_agent_credentials = var.job_agent_credentials

  tags = var.tags

  depends_on = [
    module.sqlserver,
    module.elasticpool
  ]
}