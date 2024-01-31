#data "azurerm_subnet" "subnet_a" {
#  name                 = "subnet-a"
#  resource_group_name  = "rg-${var.env_type}"
#  virtual_network_name = "private-${var.env_type}-network"
#}

data "azurerm_resource_group" "main" {
  name = "rg-${var.env_type}"
}