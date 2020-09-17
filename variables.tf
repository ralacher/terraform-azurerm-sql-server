# Azure variables
variable "resource_group_name" {
  description = "The name of the resource group where the SQL server resides. Changing this forces a new resource to be created"
  type        = string
}

# Azure Active Directory variables
variable "sql_administrator_active_directory_group" {
  description = "The name of the group to be added as the Active Directory administrator of the server."
  type        = string
}

# Azure SQL Server variables
variable "server_name" {
  description = "The name of the Microsoft SQL Server. This needs to be globally unique within Azure."
  type        = string
}

variable "server_location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "server_administrator_username" {
  description = "The administrator login name for the new server. Changing this forces a new resource to be created."
  type        = string
}

variable "server_version" {
  description = "The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
  type        = string
  default = "12.0"
}

variable "server_connection_policy" {
  description = "The connection policy the server will use. Possible values are Default, Proxy, and Redirect. Defaults to Default."
  type        = string
  default = "Default"
}

# Azure SQL Server firewall rule variables
variable "server_firewall_rules" {
  description = "List of firewall rule objects that will be whitelisted on the server"
  type = list(object({
    name             = string,
    start_ip_address = string,
    end_ip_address   = string
  }))
}

variable "server_firewall_rules_allow_azure" {
  description = "Specifies whether to whitelist Azure datacenter IP addresses on the server."
  type        = bool
  default = false
}

# Azure Storage variables for Extended Auditing
variable "enable_auditing" {
  description = "Specifies whether to enable extended auditing for the SQL Server."
  type        = bool
  default = false
}

variable "storage_account_access_key" {
  description = "Specifies the access key to use for the auditing storage account."
  type        = string
  default = false
}

variable "storage_account_endpoint" {
  description = "Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net)."
  type        = string
  default = false
}

variable "storage_account_access_key_is_secondary" {
  description = "Specifies whether storage_account_access_key value is the storage's secondary key."
  type        = bool
}

variable "storage_account_retention_in_days" {
  description = "Specifies the number of days to retain logs for in the storage account."
  type        = number
}
