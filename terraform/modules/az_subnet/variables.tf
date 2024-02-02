variable "subnet_name" {
  type        = string
  description = "(Required) Subnet name."
}

variable "resource_group_name" {
  type    = string
  default = "(Required) Resource group name to create subnet in."
}

variable "virtual_network_name" {
  type        = string
  description = "(Required) Virtual network to attach subnet."
}

variable "address_prefixes" {
  type        = list(string)
  description = "(Required) The address prefixes to use for the subnet."
}

variable "service_endpoints" {
  type        = list(string)
  description = "(Optional) Service endpoints"
  default     = null
}