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
  description = "The name of the MSSQL elastic pool(s)."
  default     = {}
}

variable "firewall_rules" {
  type        = list(string)
  description = "Specifies the Start IP Address associated with this Firewall Rule."
  default     = []
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

variable "tags" {
  type = map(string)
  default = {
    environment : "dev"
  }
}

variable "job_agent_credentials" {
  description = "username and password for an elastic job agent"
  default     = null
}

variable "private_endpoints" {
  description = "(Optional) Options to enable private endpoint"
  default     = null
}

variable "primary_mi_id" {
  default = null
}

variable "account_replication_type" {
  description = "(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
  default     = "LRS"
}