variable "network_address_space" {
  type        = list(string)
  description = "One or many network CIDRs."
}

variable "network_dns_servers" {
  type        = list(string)
  description = "(Optional) DNS servers"
  default     = null
}

variable "network_name" {
  type        = string
  description = "Virtual Network name."
}

variable "resource_group_name" {
  type        = string
  description = "Virtual Network name."
}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
    })
  )

  default = {}
}