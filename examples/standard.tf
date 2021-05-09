module "sqlserver" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-server.git"

  name                             = "servername"
  environment                      = "dev"
  dependencies                     = []
  mssql_version                    = "12.0"
  list_of_subnets                  = []
  ssl_minimal_tls_version_enforced = "1.2"
  firewall_rules                   = []

  // Runner
  // 
  location       = var.location
  resource_group = var.rg
}

module "db" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-database.git"

  name        = "databasename"
  environment = "dev"
  server_id   = module.sqlserver.id
  server_name = module.sqlserver.name
  dbowner     = "firstname.lastname@example.ca"
}

module "elasticpool" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-elasticpool.git"

  name         = "elasticpoolname"
  server_name  = module.sqlserver.name
  max_size_gb  = 9.7656250
  skuname      = "BasicPool"
  tier         = "Basic"
  capacity     = 100
  min_capacity = 0
  max_capacity = 5

  // Runner
  // 
  location       = var.location
  resource_group = var.rg
}
