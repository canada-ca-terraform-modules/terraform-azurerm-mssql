module "mssql" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql?ref=v2.0.4"

  mssql_name          = "sqlservername001"
  location            = "canadacentral"
  environment         = "dev"
  resource_group_name = "hosting-sql-dev-rg"

  db_names = {
    "mydb1" = { str_days = "35", sku = "GP_Gen5_4" },
    "mydb2" = { ltr_monthly_retention = "P2M", sku = "GP_Gen5_4" },
    "mydb3" = { ltr_week_of_year = "2", sku = "GP_Gen5_4" },
    "mydb4" = { ltr_weekly_retention = "P3W", sku = "GP_Gen5_4" },
    "mydb5" = { str_days = "35", ltr_yearly_retention = "P2Y", ltr_week_of_year = "2", ltr_weekly_retention = "P3W", ltr_monthly_retention = "P2M", sku = "GP_Gen5_4" }
  }

  db_owners = ["HostingDevSQL"] #Your AD Group or cloud username

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