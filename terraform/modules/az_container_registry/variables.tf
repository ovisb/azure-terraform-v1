variable "name" {
  type        = string
  description = "Container registry name."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name to deploy registry in."
}

variable "location" {
  type        = string
  description = "Azure location where the resource exists"
}

variable "sku" {
  type        = string
  description = "The SKU name of the container registry."
  default     = "standard"
}