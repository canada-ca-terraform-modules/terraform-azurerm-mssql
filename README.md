# Terraform for Azure Managed Database MSSQL

Creates a MSSQL instance using the Azure Managed Database for MSSQL service.

## Security Controls

- Adheres to the [CIS Microsoft Azure Foundations Benchmark 1.3.0](https://docs.microsoft.com/en-us/azure/governance/policy/samples/cis-azure-1-3-0) for Database Services.

## Dependencies

- Terraform v0.14.x +
- Terraform AzureRM Provider 2.5 +

## Relationships

- [MSSQL](https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql)
- [MSSQL Database](https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-database)
- [MSSQL Elasticpool](https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-elasticpool)
- [MSSQL Server](https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-server)

## Usage

Examples for this module along with various configurations can be found in the [examples/](examples/) folder.

## Variables

| Name                                          | Type    | Default   | Required | Description                                                                                                                                                                                                                 |
|-----------------------------------------------|---------|-----------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| administrator_login                           | string  | n/a       | yes      | The Administrator Login for the MSSQL Server.                                                                                                                                                                               |
| administrator_login_password                  | string  | n/a       | yes      | The Password associated with the administrator_login for the MSSQL Server.                                                                                                                                                  |
| active_directory_administrator_login_username | string  | n/a       | yes      | The Active Directory Administrator Login Username.                                                                                                                                                                          |
| active_directory_administrator_object_id      | string  | n/a       | yes      | The Active Directory Administrator Object ID.                                                                                                                                                                               |
| active_directory_administrator_tenant_id      | string  | n/a       | yes      | The Active Directory Administrator Tenant ID.                                                                                                                                                                               |
| database_names                                | list    | n/a       | yes      | The name of the PostgreSQL database(s).                                                                                                                                                                                     |
| dbowner                                       | string  | n/a       | yes      | The name of the user or group that will be granted dbmanager, loginmanager (master) and db_owner on their database.                                                                                                         |
| db_sku_name                                   | string  | n/a       | no       | Specifies the name of the sku used by the database.                                                                                                                                                                         |
| emails                                        | list    | n/a       | yes      | List of email addresses that should recieve the security reports.                                                                                                                                                           |
| environment                                   | string  | n/a       | yes      | The name of the subscription.                                                                                                                                                                                               |
| firewall_rules                                | list    | n/a       | yes      | List the IPs that are allowed.                                                                                                                                                                                              |
| keyvault_enable                               | string  | `"false"` | no       | Enable Threat Detection Policy.                                                                                                                                                                                             |
| kv_name                                       | string  | n/a       | yes      | The keyvault name.                                                                                                                                                                                                          |
| kv_rg                                         | string  | n/a       | yes      | The keyvault resource group.                                                                                                                                                                                                |
| list_of_subnets                               | list    | n/a       | yes      | List of subnets (local.backCCSubnetRef, local.midCCsubnetRef etc.)                                                                                                                                                          |
| location                                      | string  | n/a       | yes      | Specifies the supported Azure location where the resource exists.                                                                                                                                                           |
| max_size_gb                                   | decimal | n/a       | no       | The max data size of the elastic pool in gigabytes. Conflicts with max_size_bytes.                                                                                                                                          |
| module_elasticpool_count                      | int     | 0         | yes      | The count used to determine whether or not the db module is leveraged.                                                                                                                                                      |
| module_sqlserver_count                        | int     | 1         | yes      | The count used to determine whether or not the db module is leveraged.                                                                                                                                                      |
| mssql_version                                 | string  | n/a       | yes      | The version of the MSSQL Server.                                                                                                                                                                                            |
| name                                          | string  | n/a       | yes      | The name to pass to the MSSQL modules.                                                                                                                                                                                      |
| pool_sku_name                                 | string  | n/a       | yes      | Specifies the SKU Name for this Elasticpool. The name of the SKU, will be either vCore based tier + family pattern (e.g. GP_Gen4, BC_Gen5) or the DTU based BasicPool, StandardPool, or PremiumPool pattern.                |
| rg                                            | string  | n/a       | yes      | The name of the resource group in which to create the MSSQL Server                                                                                                                                                          |
| storageaccountinfo_resource_group_name        | string  | n/a       | yes      | The storageaccountinfo resource group name.                                                                                                                                                                                 |
| tags                                          | map     | `"<map>"` | n/a      | A mapping of tags to assign to the resource.                                                                                                                                                                                |
| tier                                          | string  | n/a       | no       | The tier of the particular SKU. Possible values are GeneralPurpose, BusinessCritical, Basic, Standard, or Premium. For more information see the documentation for your Elasticpool configuration: vCore-based or DTU-based. |

## History

| Date     | Release | Change                                                                         |
|----------|---------|--------------------------------------------------------------------------------|
| 20211004 | v1.1.2  | Release introduced max_size_gb.                                                |
| 20210908 | v1.1.1  | Release which resolves issues with multiple databases                          |
| 20210628 | v1.1.0  | Release which pins versions and switches database names to list of map strings |
| 20210511 | v1.0.2  | Release which uses database_names var to determine count for database spec     |
| 20210509 | v1.0.1  | Release which switches to multi module setup for elasticpool                   |
| 20210207 | v1.0.0  | Release of Terraform module                                                    |
