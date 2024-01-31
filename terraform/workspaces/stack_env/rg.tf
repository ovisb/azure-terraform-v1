module "resource_group" {
  source = "../../modules/az_resource_group"

  name     = "rg-${var.env_type}"
  location = var.location

  tags = merge(
    var.tags,
    {
      "Name" = var.network_name
    }
  )
}