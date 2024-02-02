variable "network_address_space" {
  type        = list(string)
  description = "One or many network CIDRs."
}

variable "network_dns_servers" {
  type        = list(string)
  description = "(Optional) DNS servers"
  default     = null
}

variable "subnets" {
  type = map(object({
    address_prefixes  = list(string)
    service_endpoints = optional(list(string))
    })
  )

  default = {}
}