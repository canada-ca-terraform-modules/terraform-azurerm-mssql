module "mssql" {
  source = "git::https://gitlab.k8s.cloud.statcan.ca/managed-databases/terraform-azurerm-mssql?ref=test_sama"

  mssql_name          = "servername001"
  location            = "canadacentral"
  environment         = "dev"
  resource_group_name = "resourcegroupname"

  administrator_login                           = ""
  administrator_login_password                  = ""
  active_directory_administrator_login_username = ""
  active_directory_administrator_object_id      = ""
  active_directory_administrator_tenant_id      = ""

  kv_name                = "hostingops-sql-dev-kv"
  kv_rg                  = "hostingops-sql-dev-rg"
  kv_enable              = true
  sa_resource_group_name = "hostingops-sql-dev-rg"

  firewall_rules = [] #List of IP addresses: Ex. ["0.0.0.0"]

  #[Required] Database Configurations
  db_names = var.db_names

  /*
  #[Optional] Elastic Pool Configurations
  ep_names = var.ep_names
  */

  /*
  #[Optional] Configurations
  mssql_version                                 = var.mssql_version
  emails = concat([
    "arthur.quenneville@statcan.gc.ca",
    "tristan.wrubleski@statcan.gc.ca",
    "sama.mahmoud@statcan.gc.ca"],
    var.emails
  )  
  job_agent_credentials = var.job_agent_credentials
  */

  /*
  #[Optional] Firewall Configurations
  subnets                                       = [data.azurerm_subnet.devcc-back.id]
  ssl_minimal_tls_version_enforced              = "1.2"
  connection_policy                             = "Default"
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