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