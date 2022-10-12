variable "administrator_login" {
  description = "The Administrator Login for the MSSQL Server"
  default     = "sqlhstsvc"
}

variable "administrator_login_password" {
  description = "(Required) The Password associated with the administrator_login for the PostgreSQL Server."
}

variable "active_directory_administrator_login_username" {
  description = "The Active Directory Administrator Login Username."
  default     = ""
}

variable "active_directory_administrator_object_id" {
  description = "The Active Directory Administrator Object ID."
  default     = ""
}

variable "active_directory_administrator_tenant_id" {
  description = "The Active Directory Administrator Tenant ID."
  default     = ""
}

variable "db_names" {
  type        = list(map(string))
  description = "(Required) The name of the MSSQL database(s)."
}

variable "emails" {
  type        = list(string)
  description = "List of email addresses that should recieve the security reports."
  default     = []
}

variable "environment" {
  description = "The environment used for keyvault access."
}

variable "connection_policy" {
  description = "The connection policy the server will use (Default, Proxy or Redirect)"
  default     = "Default"
}

variable "ep_names" {
  type        = list(map(string))
  description = "The name of the MSSQL elastic pool(s)."
  default     = null
}

variable "firewall_rules" {
  type        = list(string)
  description = "Specifies the Start IP Address associated with this Firewall Rule."
}
variable "family" {
  default = null
}

variable "kv_enable" {
  description = "(Optional) Enable Key Vault for passwords."
  default     = false
}

variable "kv_name" {
  description = "The keyvault name."
  default     = ""
}

variable "kv_resource_group_name" {
  description = "The keyvault resource group."
  default     = ""
}

variable "subnets" {
  default = []
}

variable "location" {
  description = "The Azure Region in which all resources should be provisioned."
}

variable "ltr_monthly_retention" {
  description = "The monthly retention policy for an LTR backup. (1 to 120 weeks eg. P1Y, P1M, P4W, P30D)"
  default     = null
}

variable "ltr_week_of_year" {
  description = "The week of the year to take the yearly backup.  Value has to be between 1 and 52."
  default     = 52
}

variable "ltr_weekly_retention" {
  description = "The weekly retention policy for an LTR backup. (1 to 520 weeks eg. P1Y, P1M, P1W, P7D)"
  default     = "P1W"
}

variable "ltr_yearly_retention" {
  description = "The yearly retention policy for an LTR backup. (1 to 120 weeks eg. P1Y, P12M, P52W, P365D)"
  default     = null
}

variable "mssql_version" {
  description = "The version of the MSSQL Server."
  default     = "12.0"
}

variable "mssql_name" {
  description = "(Required) The name of the MSSQL instance. This needs to be globally unique. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  description = "The resource group in which all resources should be provisioned."
}

variable "str_days" {
  description = "Short Term Retention Point in Time Restore Configuration.  Values has to be between 7 and 35"
  default     = 7
}

variable "sa_resource_group_name" {
  description = "The storageaccountinfo resource group name."
  default     = ""
}

variable "private_endpoint_subnet" {
  description = "(Optional) Options to enable private endpoint."
  default     = null
}

variable "tags" {
  type = map(string)
  default = {
    environment : "dev"
  }
}

variable "create_mode" {
  description = "(Optional) Specifies how to create the database. Must be either Default to create a new database or PointInTimeRestore to restore from a snapshot. Defaults to Default."
  default     = null
}

variable "creation_source_database_id" {
  description = " (Optional) The id of the source database to be referred to create the new database. This should only be used for databases with create_mode values that use another database as reference. Changing this forces a new resource to be created."
  default     = null
}