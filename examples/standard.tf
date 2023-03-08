module "mssql_example" {
  source = "git::https://gitlab.k8s.cloud.statcan.ca/managed-databases/terraform-azurerm-mssql-statcan.git?ref=v2.0.0"

  // GLOBALS
  mssql_name          = "stdcadb-projectname"
  location            = "canadacentral"
  environment         = "sb"
  resource_group_name = data.azurerm_resource_group.this.name

  // SERVER
  emails = [
    "first.lastname@statcan.gc.ca"
  ]
  tags = {
    "tier" = "k8s"
  }
  mssql_version  = "12.0"
  firewall_rules = []
  subnets        = [data.azurerm_subnet.container.id]

  // DB
  db_names = [
    { name = "mydb1", collation = "SQL_Latin1_General_CP437_CI_AI", sku = "GP_Gen5_4" }
  ]
  db_owners = ["first.lastname@cloud.statcan.ca"]
}

module "mssql" {
  source = "git::https://gitlab.k8s.cloud.statcan.ca/managed-databases/terraform-azurerm-mssql?ref=test_sama"

  // GLOBALS
  mssql_name          = "sqlservername001"
  location            = "canadacentral"
  environment         = "dev"
  resource_group_name = "hosting-sql-dev-rg"
  mssql_version       = "12.0"

  db_names = [
    { name = "dbname", collation = "SQL_Latin1_General_CP437_CI_AI", sku = "GP_Gen5_4" }
  ]

  job_agent_credentials = var.job_agent_credentials

  firewall_rules = var.firewall_rules
  subnets        = var.subnets

  emails = ["email@domain.ca"]
  tags   = {}



  #Optional Keyvault Params
  kv_name                = local.kv_name
  kv_resource_group_name = local.kv_resource_group_name
  kv_enable              = var.kv_enable
  sa_resource_group_name = local.sa_resource_group_name

  #Optional Server Params
  administrator_login                           = ""
  administrator_login_password                  = ""
  active_directory_administrator_login_username = ""
  active_directory_administrator_object_id      = ""
  active_directory_administrator_tenant_id      = ""

  #Optional Connection Params
  connection_policy = var.connection_policy

  #[Optional] Private Endpoint
  private_endpoint_subnet_id = []




}
