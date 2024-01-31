variable "name" {
  type        = string
  description = "Virtual network name."
}

variable "location" {
  type        = string
  description = "Region to create network into."
}

variable "resource_group_name" {

}

variable "address_space" {
  type        = list(string)
  description = "One or many network CIDRs."
}

variable "dns_servers" {
  type        = list(string)
  description = "(Optional) DNS servers"
  default     = null
}

variable "subnets" {
  type = list(object({
    name           = string
    address_prefix = string
    security_group = optional(string)
  }))
  default = []
}

variable "tags" {
  type        = map(any)
  description = "(Optional) Tags"
  default     = {}
}

