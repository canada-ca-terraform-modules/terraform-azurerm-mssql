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

variable "database_names" {
  type        = list(map(string))
  description = "(Required) The name of the PostgreSQL database(s)."
}

variable "dbowner" {
  description = "Azure Active Directory Account that will be dbowner."
}

variable "db_sku_names" {
  description = "(Optional) Specifies the name of the sku used by the database. Only changing this from tier Hyperscale to another tier will force a new resource to be created. For example, GP_S_Gen5_2,HS_Gen4_1,BC_Gen5_2, ElasticPool, Basic,S0, P2 ,DW100c, DS100."
  default     = null
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

variable "elasticpools" {
  type        = list(map(string))
  description = "TBD"
  default     = [{}]
}

variable "firewall_rules" {
  type        = list(string)
  description = "Specifies the Start IP Address associated with this Firewall Rule."
}
variable "family" {
  default = null
}

variable "keyvault_enable" {
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

variable "list_of_subnets" {
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

variable "module_server_count" {
  description = "The count used to determine whether or not the sqlserver module is leveraged."
  default     = 1
}

variable "mssql_version" {
  description = "The version of the MSSQL Server."
  default     = "12.0"
}

variable "name" {
  description = "(Required) The name of the MSSQL instance. This needs to be globally unique. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  description = "The resource group in which all resources should be provisioned."
}

variable "short_retentiondays" {
  description = "Point in Time Restore Configuration.  Values has to be between 7 and 35"
  default     = 7
}

variable "storageaccountinfo_resource_group_name" {
  description = "The storageaccountinfo resource group name."
  default     = ""
}

variable "tags" {
  type = map(string)
  default = {
    environment : "dev"
  }
}

