data "azurerm_client_config" "this" {}

module "vault" {
  source = "../../modules/az_key_vault"

  name                       = "${local.aks_cluster_name}-key-vault"
  location                   = data.azurerm_resource_group.main.location
  resource_group_name        = data.azurerm_resource_group.main.name
  purge_protection_enabled   = false
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  tenant_id                  = data.azurerm_client_config.this.tenant_id
}

resource "azurerm_key_vault_access_policy" "aks" {
  key_vault_id = module.vault.id

  tenant_id = data.azurerm_client_config.this.tenant_id
  object_id = azurerm_kubernetes_cluster.main.key_vault_secrets_provider[0].secret_identity[0].object_id

  secret_permissions = [
    "Get",
    "List",
  ]

  depends_on = [azurerm_kubernetes_cluster.main]
}


output "aks_vault_id" {
  value = module.vault.id
}