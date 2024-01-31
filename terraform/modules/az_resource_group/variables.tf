variable "name" {
  type        = string
  description = "Resource group name."
}

variable "location" {
  type        = string
  description = "Resource group Azure region."
}

variable "tags" {
  type        = map(any)
  description = "(Optional) Mapping of tags"
  default     = null
}