locals {
  resource_group_name = "demo-dev"
}

data "azurerm_key_vault" "this" {
  name                = "demo-dev-aks-key-vault"
  resource_group_name = local.resource_group_name
}

data "azurerm_key_vault_secrets" "this" {
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_kubernetes_cluster" "this" {

  name                = "demo-dev-aks"
  resource_group_name = local.resource_group_name
}


resource "helm_release" "secrets_provider" {
  name    = "aks-vault"
  chart   = "./aks-vault"
  version = "0.0.1"
  values = [yamlencode({
    vaultName = data.azurerm_key_vault.this.name
    tenantId  = data.azurerm_key_vault.this.tenant_id
    clientId  = data.azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].client_id
    secrets   = data.azurerm_key_vault_secrets.this.names
  })]
  force_update     = true
  namespace        = "dev"
  create_namespace = true
}