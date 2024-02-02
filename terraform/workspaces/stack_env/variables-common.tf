variable "env_type" {
  type        = string
  description = "Environment type"
}

variable "location" {
  type        = string
  description = "Azure location where resources will be created."
}

variable "tags" {
  type        = map(any)
  description = "Map of key value tag pair"
}

variable "project_name" {
  type        = string
  description = "Project name."
}