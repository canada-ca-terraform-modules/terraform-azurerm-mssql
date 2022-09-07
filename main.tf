module "sqlserver" {
  source = "git::https://gitlab.k8s.cloud.statcan.ca/managed-databases/terraform-azurerm-mssql-server.git?ref=development_sama"
  
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
  private_endpoint = var.private_endpoint
  #tags = var.tags 
}

module "db" {
  source = "git::https://gitlab.k8s.cloud.statcan.ca/managed-databases/terraform-azurerm-mssql-database.git?ref=development_sama"
  
  count                                  = length(var.db_names)

  name                                   = var.db_names[count.index].name
  resource_group_name                    = var.resource_group_name
  collation                              = lookup(var.db_names[count.index], "collation", "SQL_Latin1_General_CP1_CI_AS")
  max_size_gb                            = lookup(var.db_names[count.index], "db_max_size_gb", null)
  str_days                    = lookup(var.db_names[count.index], "str_days", "7")
  ltr_monthly_retention                  = lookup(var.db_names[count.index], "ltr_monthly_retention", null)
  ltr_week_of_year                       = lookup(var.db_names[count.index], "ltr_week_of_year", "52")
  ltr_weekly_retention                   = lookup(var.db_names[count.index], "ltr_weekly_retention", "P1W")
  ltr_yearly_retention                   = lookup(var.db_names[count.index], "ltr_yearly_retention", null)
  create_mode                            = lookup(var.db_names[count.index], "create_mode", "Default")
  creation_source_database_id            = lookup(var.db_names[count.index], "creation_source_database_id", null)

  environment                            = var.environment
  server_id                              = module.sqlserver[0].id
  server_name                            = module.sqlserver[0].name
  sku_name                               = var.db_sku_names[count.index]
  kv_name                                = var.kv_name
  kv_rg                                  = var.kv_resource_group_name
  
  sa_resource_group_name = var.sa_resource_group_name
  sa_primary_blob_endpoint = module.sqlserver[0].sa_primary_blob_endpoint
  sa_primary_access_key    = module.sqlserver[0].sa_primary_access_key
  tags                                   = var.tags
}

module "elasticpool" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-elasticpool.git?ref=v1.0.1"
  
  count = var.ep_names == null ?  0 : length(var.ep_names)

  name                = var.ep_names[count.index].name
  location            = var.location
  resource_group_name = var.resource_group_name
  server_name         = module.sqlserver[0].name
  max_size_gb         = lookup(var.ep_names[count.index], "max_size_gb", null)
  sku_name            = lookup(var.ep_names[count.index], "sku_name", null)
  tier                = lookup(var.ep_names[count.index], "tier", null)
  family              = lookup(var.ep_names[count.index], "family", null)
  capacity            = lookup(var.ep_names[count.index], "capacity", null)
  min_capacity        = lookup(var.ep_names[count.index], "min_capacity", null)
  max_capacity        = lookup(var.ep_names[count.index], "max_capacity", null)
  tags                = var.tags
}

