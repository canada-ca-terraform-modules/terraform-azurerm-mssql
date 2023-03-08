module "sqlserver" {
  source = "git::https://gitlab.k8s.cloud.statcan.ca/managed-databases/terraform-azurerm-mssql-server?ref=test_sama_2"

  count = var.mssql_name == null ? 0 : 1

  name                                          = var.mssql_name
  environment                                   = var.environment
  location                                      = var.location
  resource_group_name                           = var.resource_group_name
  dependencies                                  = []
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
  private_endpoint_subnet_id                    = var.private_endpoint_subnet_id
  private_dns_zone_ids                          = var.private_dns_zone_ids
  tags                                          = var.tags
  primary_mi_id                                 = var.primary_mi_id
}

module "elasticpool" {
  #source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-elasticpool.git?ref=v1.0.2"
  source = "git::https://gitlab.k8s.cloud.statcan.ca/managed-databases/single-server/terraform-azurerm-mssql-elasticpool?ref=patch"
  count  = var.ep_names == null ? 0 : length(var.ep_names)

  name                = var.ep_names[count.index].name
  location            = var.location
  resource_group_name = var.resource_group_name
  server_name         = module.sqlserver[0].name
  max_size_gb         = lookup(var.ep_names[count.index], "max_size_gb", null)
  sku_name            = lookup(var.ep_names[count.index], "sku", null)
  tier                = lookup(var.ep_names[count.index], "tier", null)
  family              = lookup(var.ep_names[count.index], "family", null)
  capacity            = lookup(var.ep_names[count.index], "capacity", null)
  min_capacity        = lookup(var.ep_names[count.index], "min_capacity", null)
  max_capacity        = lookup(var.ep_names[count.index], "max_capacity", null)
  #tags                = var.tags
}


module "db" {
  #  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-database.git?ref=v2.0.1"
  source = "git::https://gitlab.k8s.cloud.statcan.ca/managed-databases/single-server/terraform-azurerm-mssql-database?ref=dev2"

  count = length(var.db_names)

  name                = var.db_names[count.index].name
  resource_group_name = var.resource_group_name
  location            = var.location
  environment         = var.environment

  collation                   = lookup(var.db_names[count.index], "collation", "SQL_Latin1_General_CP1_CI_AS")
  max_size_gb                 = lookup(var.db_names[count.index], "db_max_size_gb", null)
  min_capacity                = lookup(var.db_names[count.index], "min_capacity", 0.5)
  auto_pause_delay_in_minutes = lookup(var.db_names[count.index], "auto_pause_delay_in_minutes", 1)
  read_replica_count          = lookup(var.db_names[count.index], "read_replica_count", 0)
  read_scale                  = lookup(var.db_names[count.index], "read_scale", null)
  zone_redundant              = lookup(var.db_names[count.index], "zone_redundant", null)
  str_days                    = lookup(var.db_names[count.index], "str_days", "7")
  ltr_monthly_retention       = lookup(var.db_names[count.index], "ltr_monthly_retention", null)
  ltr_week_of_year            = lookup(var.db_names[count.index], "ltr_week_of_year", "52")
  ltr_weekly_retention        = lookup(var.db_names[count.index], "ltr_weekly_retention", "P1W")
  ltr_yearly_retention        = lookup(var.db_names[count.index], "ltr_yearly_retention", null)
  create_mode                 = lookup(var.db_names[count.index], "create_mode", "Default")
  creation_source_database_id = lookup(var.db_names[count.index], "creation_source_database_id", null)
  recover_database_id         = lookup(var.db_names[count.index], "recover_database_id", null)
  restore_dropped_database_id = lookup(var.db_names[count.index], "restore_dropped_database_id", null)
  restore_point_in_time       = lookup(var.db_names[count.index], "restore_point_in_time", null)
  sku                         = lookup(var.db_names[count.index], "sku", null)

  server_id   = module.sqlserver[0].id
  server_name = module.sqlserver[0].name

  elastic_pool_id = var.ep_names == null ? null : module.elasticpool[0].elasticpool.id

  kv_name = var.kv_name
  kv_rg   = var.kv_resource_group_name

  sa_resource_group_name   = var.sa_resource_group_name
  sa_primary_blob_endpoint = module.sqlserver[0].sa_primary_blob_endpoint
  sa_primary_access_key    = module.sqlserver[0].sa_primary_access_key

  job_agent_credentials = var.job_agent_credentials

  tags = var.tags
}


