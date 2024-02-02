locals {
  capabilities = toset(
    [
      "mongoEnableDocLevelTTL",
      "MongoDBv3.4",
      "EnableMongo"
    ]
  )
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_cosmosdb_account" "main" {
  name                          = "${var.project_name}-cosmos-db-${var.env_type}-${random_integer.ri.result}"
  location                      = data.azurerm_resource_group.main.location
  resource_group_name           = data.azurerm_resource_group.main.name
  offer_type                    = "Standard"
  kind                          = "MongoDB"
  enable_automatic_failover     = true
  public_network_access_enabled = false

  geo_location {
    failover_priority = 0
    location          = "westus"
  }

  dynamic "capabilities" {
    for_each = local.capabilities
    content {
      name = capabilities.value
    }
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  is_virtual_network_filter_enabled = true
  virtual_network_rule {
    id = data.azurerm_subnet.subnet_a.id
  }
}

resource "azurerm_key_vault_secret" "cosmo_endpoint" {
  name         = "cosmoEndpoint"
  value        = azurerm_cosmosdb_account.main.endpoint
  key_vault_id = module.vault.id
}


output "endpoint" {
  value = azurerm_cosmosdb_account.main.endpoint
}

