module "environment" {
  source = "../../workspaces/stack_env"

  resource_group_name = "rg-${var.env_type}"
  network_name        = "private-${var.env_type}-network"

  network_address_space = var.network_address_space
  #  network_dns_servers   = var.network_dns_servers
  subnets = {
    "subnet-a" = {
      address_prefixes = ["10.0.0.0/19"]
    },
    "subnet-b" = {
      address_prefixes = ["10.0.32.0/19"]
    }
  }

  location = try(var.az_location[var.env_type], "West Europe")
  env_type = "dev"

  tags = {
    "Env_Type" = "dev"
  }
}