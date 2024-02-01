resource "azurerm_user_assigned_identity" "main" {
  name                = "${var.aks_cluster_name}-main-identity"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}

resource "azurerm_role_assignment" "main" {
  scope                = data.azurerm_resource_group.main.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.main.principal_id
}

resource "azurerm_role_assignment" "acr" {
  principal_id                     = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.main.id
  skip_service_principal_aad_check = true
}

resource "azurerm_kubernetes_cluster" "main" {
  name                    = var.aks_cluster_name
  location                = data.azurerm_resource_group.main.location
  resource_group_name     = data.azurerm_resource_group.main.name
  dns_prefix              = var.aks_cluster_name
  private_cluster_enabled = false
  node_resource_group     = var.aks_cluster_name

  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  sku_tier                  = "Standard"

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.2.0.0/16"
    dns_service_ip = "10.2.0.10"
  }

  default_node_pool {
    name    = "default"
    vm_size = "Standard_D2_v2"
    #    vnet_subnet_id = data.azurerm_subnet.subnet_a.id
    node_count = 2

    node_labels = {
      role = "default"
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.main.id]
  }

  tags = {
    "Env_Type" = var.env_type
  }

  depends_on = [azurerm_role_assignment.main]
}


output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.main.name
}

