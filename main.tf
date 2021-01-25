# Part of a hack for module-to-module dependencies.
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
# and
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-473091030
# Make sure to add this null_resource.dependency_getter to the `depends_on`
# attribute to all resource(s) that will be constructed first within this
# module:
resource "null_resource" "dependency_getter" {
  triggers = {
    my_dependencies = "${join(",", var.dependencies)}"
  }

  lifecycle {
    ignore_changes = [
      triggers["my_dependencies"],
    ]
  }
}

resource "azurerm_mssql_server" "mssql" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  version = var.mssql_version

  minimum_tls_version = var.ssl_minimal_tls_version_enforced

  azuread_administrator {
    login_username = "sqladmin"
    object_id      = var.active_directory_administrator_object_id
    tenant_id      = var.active_directory_administrator_tenant_id
  }

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.mssql.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.mssql.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = var.retention_days
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_mssql_database" "mssql" {
  count        = length(var.database_names)
  name         = var.database_names[count.index]
  server_id    = azurerm_mssql_server.mssql.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = var.storagesize_gb
  sku_name     = var.sku_name

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.mssql.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.mssql.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = var.retention_days
  }
}

resource "azurerm_mssql_server_security_alert_policy" "mssql" {
  resource_group_name        = var.resource_group
  server_name                = azurerm_mssql_server.mssql.name
  state                      = "Enabled"
  storage_endpoint           = azurerm_storage_account.mssql.primary_blob_endpoint
  storage_account_access_key = azurerm_storage_account.mssql.primary_access_key
  disabled_alerts            = []
  retention_days             = var.retention_days
}

resource "azurerm_mssql_server_vulnerability_assessment" "mssql" {
  server_security_alert_policy_id = azurerm_mssql_server_security_alert_policy.mssql.id
  storage_container_path          = "${azurerm_storage_account.mssql.primary_blob_endpoint}${azurerm_storage_container.mssql.name}/"
  storage_account_access_key      = azurerm_storage_account.mssql.primary_access_key

  recurring_scans {
    enabled                   = true
    email_subscription_admins = true
    emails                    = var.vulnerability_assessment_emails
  }
}

// Configure Networking
//

resource "azurerm_sql_firewall_rule" "mssql" {
  count               = length(var.firewall_rules)
  name                = azurerm_mssql_server.mssql.name
  resource_group_name = var.resource_group
  server_name         = azurerm_mssql_server.mssql.name
  start_ip_address    = var.firewall_rules[count.index]
  end_ip_address      = var.firewall_rules[count.index]
}

resource "azurerm_sql_virtual_network_rule" "mssql" {
  name                = azurerm_mssql_server.mssql.name
  resource_group_name = var.resource_group
  server_name         = azurerm_mssql_server.mssql.name
  subnet_id           = var.subnet_id
}

# Part of a hack for module-to-module dependencies.
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
resource "null_resource" "dependency_setter" {
  # Part of a hack for module-to-module dependencies.
  # https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
  # List resource(s) that will be constructed last within the module.
  depends_on = [
    "azurerm_mssql_server.mssql",
  ]
}
