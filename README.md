# Terraform for Azure Managed Database MSSQL

## Summary
Creates a MSSQL instance using the Azure Managed Database for MSSQL service.
Examples for using the module can be found in the [examples/](examples/) folder.
Changelog can be found in CHANGELOG.md

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db"></a> [db](#module\_db) | git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-database.git | v2.0.2 |
| <a name="module_elasticpool"></a> [elasticpool](#module\_elasticpool) | git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-elasticpool.git | v1.0.1 |
| <a name="module_sqlserver"></a> [sqlserver](#module\_sqlserver) | git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-server.git | v2.0.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_active_directory_administrator_login_username"></a> [active\_directory\_administrator\_login\_username](#input\_active\_directory\_administrator\_login\_username) | The Active Directory Administrator Login Username. | `string` | `""` | no |
| <a name="input_active_directory_administrator_object_id"></a> [active\_directory\_administrator\_object\_id](#input\_active\_directory\_administrator\_object\_id) | The Active Directory Administrator Object ID. | `string` | `""` | no |
| <a name="input_active_directory_administrator_tenant_id"></a> [active\_directory\_administrator\_tenant\_id](#input\_active\_directory\_administrator\_tenant\_id) | The Active Directory Administrator Tenant ID. | `string` | `""` | no |
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | The Administrator Login for the MSSQL Server | `string` | `"sqlhstsvc"` | no |
| <a name="input_administrator_login_password"></a> [administrator\_login\_password](#input\_administrator\_login\_password) | (Required) The Password associated with the administrator\_login for the PostgreSQL Server. | `any` | n/a | yes |
| <a name="input_connection_policy"></a> [connection\_policy](#input\_connection\_policy) | The connection policy the server will use (Default, Proxy or Redirect) | `string` | `"Default"` | no |
| <a name="input_db_names"></a> [db\_names](#input\_db\_names) | (Required) The name of the MSSQL database(s). | `list(map(string))` | n/a | yes |
| <a name="input_emails"></a> [emails](#input\_emails) | List of email addresses that should recieve the security reports. | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment used for keyvault access. | `any` | n/a | yes |
| <a name="input_ep_names"></a> [ep\_names](#input\_ep\_names) | The name of the MSSQL elastic pool(s). | `list(map(string))` | `null` | no |
| <a name="input_family"></a> [family](#input\_family) | n/a | `any` | `null` | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | Specifies the Start IP Address associated with this Firewall Rule. | `list(string)` | n/a | yes |
| <a name="input_job_agent_credentials"></a> [job\_agent\_credentials](#input\_job\_agent\_credentials) | username and password for an elastic job agent | `any` | `null` | no |
| <a name="input_kv_enable"></a> [kv\_enable](#input\_kv\_enable) | (Optional) Enable Key Vault for passwords. | `bool` | `false` | no |
| <a name="input_kv_name"></a> [kv\_name](#input\_kv\_name) | The keyvault name. | `string` | `""` | no |
| <a name="input_kv_rg"></a> [kv\_rg](#input\_kv\_rg) | The keyvault resource group. | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region in which all resources should be provisioned. | `any` | n/a | yes |
| <a name="input_mssql_name"></a> [mssql\_name](#input\_mssql\_name) | (Required) The name of the MSSQL instance. This needs to be globally unique. Changing this forces a new resource to be created. | `any` | n/a | yes |
| <a name="input_mssql_version"></a> [mssql\_version](#input\_mssql\_version) | The version of the MSSQL Server. | `string` | `"12.0"` | no |
| <a name="input_primary_mi_id"></a> [primary\_mi\_id](#input\_primary\_mi\_id) | n/a | `any` | `null` | no |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | (Optional) Specifies the list of Private DNS Zones to include within the private\_dns\_zone\_group | `any` | `null` | no |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | (Optional) Options to enable private endpoint | `any` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group in which all resources should be provisioned. | `any` | n/a | yes |
| <a name="input_sa_resource_group_name"></a> [sa\_resource\_group\_name](#input\_sa\_resource\_group\_name) | The storageaccountinfo resource group name. | `string` | `""` | no |
| <a name="input_str_days"></a> [str\_days](#input\_str\_days) | Short Term Retention Point in Time Restore Configuration.  Values has to be between 7 and 35 | `number` | `7` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | `list` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | <pre>{<br>  "environment": "dev"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db"></a> [db](#output\_db) | n/a |
| <a name="output_elasticpool"></a> [elasticpool](#output\_elasticpool) | n/a |
| <a name="output_sqlserver"></a> [sqlserver](#output\_sqlserver) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## History

| Date     | Release | Change                                                                         |
|----------|---------|--------------------------------------------------------------------------------|
| 20221004 | v2.0.1  | Release updated references to canada-ca tf github modules                      |
| 20221028 | v2.0.0  | Release introduced streamlined and semantically named variables                |
| 20211004 | v1.1.2  | Release introduced max_size_gb.                                                |
| 20210908 | v1.1.1  | Release which resolves issues with multiple databases                          |
| 20210628 | v1.1.0  | Release which pins versions and switches database names to list of map strings |
| 20210511 | v1.0.2  | Release which uses database_names var to determine count for database spec     |
| 20210509 | v1.0.1  | Release which switches to multi module setup for elasticpool                   |
| 20210207 | v1.0.0  | Release of Terraform module                                                    |
