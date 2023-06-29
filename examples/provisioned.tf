module "mssql" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql?ref=v2.0.4"

  mssql_name          = "sqlservername001"
  location            = "canadacentral"
  environment         = "dev"
  resource_group_name = "hosting-sql-dev-rg"

  db_names = {
    "provisionedbasic"      = { sku = "GP_Gen5_2" },
    "provisionedallconfigs" = { sku = "GP_Gen5_2", collation = "SQL_Latin1_General_CP1_CI_AS", max_size_gb = 32, min_capacity = 0.5, str_days = 7, ltr_monthly_retention = "P1Y", ltr_weekly_retention = "P1W", ltr_yearly_retention = "P1Y", ltr_week_of_year = "52" }
  }

  db_owners = ["HostingDevSQL"] #Your AD Group or email

  administrator_login                           = ""
  administrator_login_password                  = ""
  active_directory_administrator_login_username = ""
  active_directory_administrator_object_id      = ""
  active_directory_administrator_tenant_id      = ""

  kv_enable              = true
  kv_name                = "hostingops-sql-dev-kv"
  kv_resource_group_name = "hostingops-sql-dev-rg"
  sa_resource_group_name = "hostingops-sql-dev-rg"


  #[Optional] Configurations 
  #emails                                        = ["first.lastname@statcan.gc.ca"]
  #mssql_version                                 = "12.0"
  #retention_days                                = 90
  #job_agent_credentials                         = { username = "username", password = "password" }

  #[Optional] Elastic Pool Configurations
  /*ep_names = [
    { name = "standard_dev_pool_01", max_size_gb = 4.8828125, sku = "BasicPool", tier = "Basic", capacity = 50, max_capacity = 5, min_capacity = 0}
  ]*/

  #[Optional] Firewall Configurations
  firewall_rules = []
  #subnets                                       = [data.azurerm_subnet.devcc-back.id]
  #ssl_minimal_tls_version_enforced              = "1.2"
  #connection_policy                             = "Default"

  #[Optional] User Assigned Managed Identity Configurations
  #primary_mi_id                                 = "abcdefg1234567"

  #Private Endpoint Configurations
  private_endpoint_subnet_id = data.azurerm_subnet.devcc-back.id
  private_dns_zone_ids       = [data.azurerm_private_dns_zone.mssql.id]

  tags = {
    "tier" = "k8s"
  }
}