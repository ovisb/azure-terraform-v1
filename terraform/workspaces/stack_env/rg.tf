locals {
  rg_name = "${var.project_name}-${var.env_type}"
}

module "resource_group" {
  source = "../../modules/az_resource_group"

  name     = local.rg_name
  location = var.location

  tags = merge(
    var.tags,
    {
      "Name" = local.rg_name
    }
  )
}

output "rg_name" {
  value = module.resource_group.name
}