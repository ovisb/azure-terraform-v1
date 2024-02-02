module "subnet" {
  source   = "../../modules/az_subnet"
  for_each = var.subnets

  subnet_name          = "${var.project_name}-${var.env_type}-${each.key}"
  address_prefixes     = each.value.address_prefixes
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.network.name

  service_endpoints = each.value.service_endpoints
}