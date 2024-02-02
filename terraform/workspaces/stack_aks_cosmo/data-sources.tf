data "azurerm_subnet" "subnet_a" {
  name                 = "${var.project_name}-${var.env_type}-subnet-a"
  resource_group_name  = "${var.project_name}-${var.env_type}"
  virtual_network_name = "${var.project_name}-${var.env_type}-network"
}

data "azurerm_resource_group" "main" {
  name = "${var.project_name}-${var.env_type}"
}

data "azurerm_container_registry" "main" {
  name                = "${var.project_name}${var.env_type}registry0001"
  resource_group_name = "${var.project_name}-${var.env_type}"
}