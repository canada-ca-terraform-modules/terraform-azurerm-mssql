# Terraform for Azure Managed Database MSSQL

The overall flow for this module is pretty simple:

* Create Azure storage account to store Terraform state
* Create Azure managed database configuration in a modular manner
* Add any extensions you need for the MSSQL managed database service

## Security Controls

* None

## Dependencies

* None

## Optional (depending on options configured)

* None

## Usage

```terraform
name                             = var.managed_mssql_name
database_names                   = ["application"]
dependencies                     = []
administrator_login              = "mssqladmin"
administrator_login_password     = var.managed_mssql_password
sku_name                         = "GP_Gen5_4"
mssql_version                    = "12.0"
storagesize_gb                   = 256
location                         = "canadacentral"
resource_group                   = "XX-XXXX-XXXX-XXX-XXX-RGP"
subnet_id                        = var.managed_mssql_subnet_id
firewall_rules                   = []
ssl_minimal_tls_version_enforced = "1.2"
vulnerability_assessment_emails  = []
```

## Variables Values

| Name                             | Type   | Required | Value                                                                            |
|----------------------------------|--------|----------|----------------------------------------------------------------------------------|
| name                             | string | yes      | The name of the MSSQL Server                                                     |
| database_names                   | list   | yes      | The name of the MSSQL database(s)                                                |
| dependencies                     | list   | yes      | Dependency management of resources                                               |
| administrator_login              | string | yes      | The Administrator Login for the MSSQL Server                                     |
| administrator_login_password     | string | yes      | The Password associated with the administrator_login for the MSSQL Server        |
| retention_days                   | int    | yes      | Specifies the retention in days for logs for this MSSQL Server                   |
| sku_name                         | string | yes      | Specifies the SKU Name for this MSSQL Server                                     |
| mssql_version                    | string | yes      | The version of the MSSQL Server                                                  |
| storagesize_mb                   | string | yes      | Specifies the version of MSSQL to use                                            |
| location                         | string | yes      | Specifies the supported Azure location where the resource exists                 |
| resource_group                   | string | yes      | The name of the resource group in which to create the MSSQL Server               |
| subnet_id                        | string | yes      | The ID of the subnet that the MSSQL server will be connected to                  |
| firewall_rules                   | list   | yes      | Specifies the Start IP Address associated with this Firewall Rule                |
| ssl_minimal_tls_version_enforced | string | yes      | The mimimun TLS version to support on the sever                                  |
| vulnerability_assessment_emails  | string | yes      | List of email addresses that should recieve the vulnerability assessment reports |

## History

| Date     | Release    | Change                                     |
|----------|------------|--------------------------------------------|
| 20210207 | 20210207.1 | The v1.0.0 relase of Terraform module      |
