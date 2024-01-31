resource "azurerm_kubernetes_cluster" "main" {
  name                = var.aks_cluster_name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  dns_prefix          = var.aks_cluster_name

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  private_cluster_enabled = true

  tags = {
    "Env_Type" = var.env_type
  }
}


output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.main.name
}