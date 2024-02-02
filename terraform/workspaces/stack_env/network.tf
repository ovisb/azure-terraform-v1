locals {
  network_name = "${var.project_name}-${var.env_type}-network"
}

module "network" {
  source = "../../modules/az_virtual_network"

  name                = local.network_name
  location            = var.location
  resource_group_name = module.resource_group.name
  address_space       = var.network_address_space
  dns_servers         = var.network_dns_servers

  tags = merge(
    var.tags,
    {
      "Name" = local.network_name
    }
  )
}

output "network_name" {
  value = module.network.name
}