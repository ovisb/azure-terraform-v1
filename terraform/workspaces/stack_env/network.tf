module "private_db_network" {
  source = "../../modules/az_virtual_network"

  name                = var.network_name
  location            = var.location
  resource_group_name = module.resource_group.name
  address_space       = var.network_address_space
  dns_servers         = var.network_dns_servers

  tags = merge(
    var.tags,
    {
      "Name" = var.network_name
    }
  )
}