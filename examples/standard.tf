module "mssql" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql?ref=v2.0.3"

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

  firewall_rules = var.firewall_rules

  db_names = [
    { name = "dbname", collation = "SQL_Latin1_General_CP437_CI_AI", sku = "GP_Gen5_4" }
  ]

  /*
  [Optional] Configurations 
  #mssql_version                                 = "12.0"
  #emails                                        = ["name@domain.ca"]
  #retention_days                                = 90
  #account_replication_type                      = "ZRS"

  */

  /*
  #[Optional] Elastic Pool Configurations
  ep_names = [
    { name = "standard_dev_pool_01", max_size_gb = 4.8828125, sku = "BasicPool", tier = "Basic", capacity = 50, max_capacity = 5, min_capacity = 0}
  ]
  */

  /*
  #[Optional] Firewall Configurations
  #subnets                                       = [data.azurerm_subnet.devcc-back.id]
  #ssl_minimal_tls_version_enforced              = "1.2"
  #connection_policy                             = "Default"
  */

  /*
  #[Optional] User Assigned Managed Identity Configurations
  primary_mi_id = "abcdefg1234567"
  */

  /*
  #[Optional] Private Endpoint Configurations
  private_endpoint_subnet_id                    = [data.azurerm_subnet.devcc-back.id]
  private_dns_zone_ids                          = [data.azurerm_private_dns_zone.mssql.id]
  */

  tags = { "key" : "value" }
}
