module "acr" {
  source = "../../modules/az_container_registry"

  name                = "${var.env_type}registry0001"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  sku = "Standard"
}