# Storage Accounts

resource "azurerm_storage_account" "mssql" {
  name                     = "${replace(var.name, "-", "")}mssql"
  location                 = var.location
  resource_group_name      = var.resource_group
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  # enable_blob_encryption = "True"
  # enable_file_encryption = "True"
  access_tier               = "Hot"
  enable_https_traffic_only = true
}

resource "azurerm_storage_container" "mssql" {
  name                  = "${replace(var.name, "-", "")}mssql"
  storage_account_name  = azurerm_storage_account.mssql.name
  container_access_type = "private"
}
