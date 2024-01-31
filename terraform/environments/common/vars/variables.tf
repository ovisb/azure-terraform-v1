variable "env_type" {
  description = "Environment type"
}

variable "az_location" {
  type = map(string)
  default = {
    "dev" : "West Europe"
  }
}

variable "network_address_space" {
  type        = list(string)
  description = "One or many network CIDRs."
}

variable "network_dns_servers" {
  type        = list(string)
  description = "(Optional) DNS servers"
  default     = null
}