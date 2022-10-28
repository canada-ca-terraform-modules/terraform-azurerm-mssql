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