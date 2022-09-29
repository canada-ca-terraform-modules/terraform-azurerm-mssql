# Terraform for Azure Managed Database MSSQL

Creates a MSSQL instance using the Azure Managed Database for MSSQL service.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements


## Providers


## Resources


## Modules


## Inputs


## Outputs


## Relationships


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Security Controls

- Adheres to the [CIS Microsoft Azure Foundations Benchmark 1.3.0](https://docs.microsoft.com/en-us/azure/governance/policy/samples/cis-azure-1-3-0) for Database Services.


## Usage

Examples for this module along with various configurations can be found in the [examples/](examples/) folder.


## History

| Date     | Release | Change                                                                         |
|----------|---------|--------------------------------------------------------------------------------|
| 20211004 | v1.1.2  | Release introduced max_size_gb.                                                |
| 20210908 | v1.1.1  | Release which resolves issues with multiple databases                          |
| 20210628 | v1.1.0  | Release which pins versions and switches database names to list of map strings |
| 20210511 | v1.0.2  | Release which uses database_names var to determine count for database spec     |
| 20210509 | v1.0.1  | Release which switches to multi module setup for elasticpool                   |
| 20210207 | v1.0.0  | Release of Terraform module                                                    |
