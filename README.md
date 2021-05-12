# Terraform for Azure Managed Database MSSQL

Creates a MSSQL instance using the Azure Managed Database for MSSQL service.

## Security Controls

* Adheres to the [CIS Microsoft Azure Foundations Benchmark 1.3.0](https://docs.microsoft.com/en-us/azure/governance/policy/samples/cis-azure-1-3-0) for Database Services.

## Dependencies

* Terraform v0.14.x +
* Terraform AzureRM Provider 2.5 +

## Relationships

* [MSSQL](https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql)
* [MSSQL Database](https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-database)
* [MSSQL Elasticpool](https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-elasticpool)
* [MSSQL Server](https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-server)

## Usage

Examples for this module along with various configurations can be found in the [examples/](examples/) folder.

## Variables

| Name                                          | Type    | Default   | Required | Description                                                                                                                                                                                                                 |
|-----------------------------------------------|---------|-----------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| name                                          | string  | n/a       | yes      | The name to pass to the MSSQL modules.                                                                                                                                                                                      |
| environment                                   | string  | n/a       | yes      | The name of the subscription.                                                                                                                                                                                               |
| location                                      | string  | n/a       | yes      | Specifies the supported Azure location where the resource exists                                                                                                                                                            |
| rg                                            | string  | n/a       | yes      | The name of the resource group in which to create the MSSQL Server                                                                                                                                                          |
| mssql_version                                 | string  | n/a       | yes      | The version of the MSSQL Server                                                                                                                                                                                             |
| max_size_gb                                   | decimal | n/a       | no       | The max data size of the elastic pool in gigabytes. Conflicts with max_size_bytes.                                                                                                                                          |
| database_names                                | list    | n/a       | yes      | The name of the PostgreSQL database(s).                                                                                                                                                                                     |
| dbowner                                       | string  | n/a       | yes      | The name of the user or group that will be granted dbmanager, loginmanager (master) and db_owner on their database,                                                                                                         |
| firewall_rules                                | list    | n/a       | yes      | List the IPs that are allowed.                                               |
| list_of_subnets                               | list    | n/a       | yes      | List of subnets (local.backCCSubnetRef, local.midCCsubnetRef etc.)           |
| skuname                                       | string  | n/a       | yes      | Specifies the SKU Name for this Elasticpool. The name of the SKU, will be either vCore based tier + family pattern (e.g. GP_Gen4, BC_Gen5) or the DTU based BasicPool, StandardPool, or PremiumPool pattern.                |
| tier                                          | string  | n/a       | no       | The tier of the particular SKU. Possible values are GeneralPurpose, BusinessCritical, Basic, Standard, or Premium. For more information see the documentation for your Elasticpool configuration: vCore-based or DTU-based. |
| active_directory_administrator_login_username | string  | n/a       | yes      | The Active Directory Administrator Login Username.                                                                                                                                                                          |
| active_directory_administrator_object_id      | string  | n/a       | yes      | The Active Directory Administrator Object ID.                                                                                                                                                                               |
| active_directory_administrator_tenant_id      | string  | n/a       | yes      | The Active Directory Administrator Tenant ID.                                                                                                                                                                               |
| emails                                        | list    | n/a       | yes      | List of email addresses that should recieve the security reports                                                                                                                                                            |
| kv_name                                       | string  | n/a       | yes      | The keyvault name.                                                                                                                                                                                                          |
| kv_rg                                         | string  | n/a       | yes      | The keyvault resource group.                                                                                                                                                                                                |
| storageaccountinfo_resource_group_name        | string  | n/a       | yes      | The storageaccountinfo resource group name.                                                                                                                                                                                 |
| module_elasticpool_count                      | int     | 0         | yes      | The count used to determine whether or not the db module is leveraged.                                                                                                                                                      |
| module_sqlserver_count                        | int     | 1         | yes      | The count used to determine whether or not the db module is leveraged.                                                                                                                                                      |
| emails                                        | list    | n/a       | yes      | List of email addresses that should recieve the security reports                                                                                                                                                            |
| tags                                          | map     | `"<map>"` | n/a      | A mapping of tags to assign to the resource.                                                                                                                                                                                |

## History

| Date     | Release    | Change                                                                                |
|----------|------------|---------------------------------------------------------------------------------------|
| 20210511 | 20210511.1 | The v1.0.2 release which uses database_names var to determine count for database spec |
| 20210509 | 20210509.1 | The v1.0.1 release which switches to multi module setup for elasticpool               |
| 20210207 | 20210207.1 | The v1.0.0 release of Terraform module                                                |
