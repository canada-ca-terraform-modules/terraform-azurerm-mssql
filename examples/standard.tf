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


  db_names = [
    { name = "dbname", collation = "SQL_Latin1_General_CP437_CI_AI", sku = "GP_Gen5_4" }
  ]

  job_agent_credentials = var.job_agent_credentials

  firewall_rules = var.firewall_rules
  subnets        = var.subnets

  emails = ["email@domain.ca"]
  tags   = {}


  mssql_version = "12.0"
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


module "mssql" {
  source = "git::https://gitlab.k8s.cloud.statcan.ca/managed-databases/terraform-azurerm-mssql?ref=test_sama"

  // GLOBALS
  mssql_name          = var.mssql_name
  location            = var.location
  environment         = var.environment
  resource_group_name = var.resource_group_name

  // KEYVAULT
  kv_name                = local.kv_name
  kv_resource_group_name = local.kv_resource_group_name
  kv_enable              = var.kv_enable
  sa_resource_group_name = local.sa_resource_group_name

  // SERVER
  mssql_version                                 = var.mssql_version
  administrator_login                           = var.administrator_login
  administrator_login_password                  = var.administrator_login_password
  active_directory_administrator_login_username = "Hosting-SQL"
  active_directory_administrator_object_id      = "124d16c2-ef85-4359-964d-26b4016c6807"
  active_directory_administrator_tenant_id      = "258f1f99-ee3d-42c7-bfc5-7af1b2343e02"
  emails = concat([
    "arthur.quenneville@statcan.gc.ca",
    "tristan.wrubleski@statcan.gc.ca",
    "sama.mahmoud@statcan.gc.ca"],
    var.emails
  )
  connection_policy = var.connection_policy
  firewall_rules    = var.firewall_rules
  subnets           = var.subnets

  // PRIVATE ENDPOINTS
  private_endpoint_subnet_id = var.private_endpoint_subnet_id
  private_dns_zone_ids       = var.private_dns_zone_ids

  // DB
  db_names              = var.db_names
  job_agent_credentials = var.job_agent_credentials

  // ELASTIC POOL
  ep_names = var.ep_names

  // USER ASSIGNED MANAGED IDENTITY
  primary_mi_id = var.primary_mi_id

  tags = merge({
    "serviceLine"        = "sqlazdb"
    "tier"               = "back"
    "buildVersion"       = "v1"
    "buildCertification" = "Yes"
    "supportTeam"        = "hosting-sql"
    "terraformModule" = "mssqldb?ref=v2.0.4" },
    var.tags
  )
}