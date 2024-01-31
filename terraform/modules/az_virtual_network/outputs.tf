output "id" {
  value       = azurerm_virtual_network.main.id
  description = "Virtual network ID."
}

output "name" {
  value = azurerm_virtual_network.main.name
}

output "subnet" {
  value = azurerm_virtual_network.main.subnet
}