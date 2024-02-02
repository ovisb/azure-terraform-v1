variable "name" {
  type        = string
  description = "Kubernetes cluster name."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name to deploy cluster in."
}

variable "location" {
  type        = string
  description = "Azure location where the cluster will be created."
}

variable "tenant_id" {
  type        = string
  description = " The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
}

variable "sku_name" {
  type        = string
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium"
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
  default     = null
}

variable "soft_delete_retention_days" {
  type        = number
  description = "(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90"
}

variable "purge_protection_enabled" {
  type        = string
  description = "(Optional) Is Purge Protection enabled for this Key Vault?"
}

