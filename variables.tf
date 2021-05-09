variable "name" {
  description = "(Required) The name of the MSSQL instance. This needs to be globally unique. Changing this forces a new resource to be created."
}

variable "dbowner" {
  description = "Azure Active Directory Account that will be dbowner"
}

variable "environment" {
  description = "The environment used for keyvault access"
}

variable "location" {
  description = "The Azure Region in which all resources should be provisioned."
}

variable "max_size_gb" {
  description = "(Optional) The max data size of the elastic pool in gigabytes. Conflicts with max_size_bytes."
  default     = null
}

variable "mssql_version" {
  description = "The version of the MSSQL Server"
  default     = "12.0"
}

variable "rg" {
  description = "The resource group in which all resources should be provisioned."
}

variable "skuname" {
  description = "(Required) Specifies the SKU Name for this Elasticpool. The name of the SKU, will be either vCore based tier + family pattern (e.g. GP_Gen4, BC_Gen5) or the DTU based BasicPool, StandardPool, or PremiumPool pattern."
}

variable "tier" {
  description = "(Required) The tier of the particular SKU. Possible values are GeneralPurpose, BusinessCritical, Basic, Standard, or Premium. For more information see the documentation for your Elasticpool configuration: vCore-based or DTU-based."
}

variable "kv_name" {
  description = "The keyvault name"
  default     = ""
}

variable "kv_rg" {
  description = "The keyvault resource group"
  default     = ""
}

variable "storageaccountinfo_resource_group_name" {
  description = "The storageaccountinfo resource group name"
  default     = ""
}

variable "administrator_login" {
  description = "The Administrator Login for the MSSQL Server"
  default     = "sqlhstsvc"
}

variable "active_directory_administrator_login_username" {
  description = "The Active Directory Administrator Login Username"
  default     = ""
}

variable "active_directory_administrator_object_id" {
  description = "The Active Directory Administrator Object ID"
  default     = ""
}

variable "active_directory_administrator_tenant_id" {
  description = "The Active Directory Administrator Tenant ID"
  default     = ""
}

variable "module_db_count" {
  description = "The count used to determine whether or not the db module is leveraged."
  default     = 1
}

variable "module_elasticpool_count" {
  description = "The count used to determine whether or not the elasticpool module is leveraged."
  default     = 0
}

variable "module_server_count" {
  description = "The count used to determine whether or not the sqlserver module is leveraged."
  default     = 1
}

variable "emails" {
  type        = list(string)
  description = "List of email addresses that should recieve the security reports"
  default     = []
}

variable "tags" {
  type = map(string)
  default = {
    environment : "dev"
  }
}
