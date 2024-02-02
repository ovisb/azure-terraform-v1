locals {
  aks_cluster_name = "${var.project_name}-${var.env_type}-aks"
}

resource "azurerm_user_assigned_identity" "network" {
  name                = "${local.aks_cluster_name}-network-identity"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}

resource "azurerm_role_assignment" "network" {
  scope                = data.azurerm_resource_group.main.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.network.principal_id
}

resource "azurerm_role_assignment" "acr" {
  principal_id                     = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.main.id
  skip_service_principal_aad_check = true
}

resource "azurerm_kubernetes_cluster" "main" {
  name                    = local.aks_cluster_name
  location                = data.azurerm_resource_group.main.location
  resource_group_name     = data.azurerm_resource_group.main.name
  dns_prefix              = local.aks_cluster_name
  private_cluster_enabled = false
  node_resource_group     = local.aks_cluster_name

  sku_tier = "Standard"

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.2.0.0/16"
    dns_service_ip = "10.2.0.10"
  }

  default_node_pool {
    name           = "default"
    vm_size        = "Standard_D2_v2"
    vnet_subnet_id = data.azurerm_subnet.subnet_a.id
    node_count     = 2

    node_labels = {
      role = "default"
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.network.id]
  }

  # CSI driver
  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  tags = {
    "Env_Type" = var.env_type
  }

  depends_on = [azurerm_role_assignment.network]
}


output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.main.name
}

