module "environment" {
  source = "../../workspaces/stack_env"

  project_name = "demo"

  network_address_space = var.network_address_space
  subnets = {
    "subnet-a" = {
      address_prefixes  = ["10.0.0.0/19"],
      service_endpoints = ["Microsoft.AzureCosmosDB"]
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


output "acr_name" {
  value = module.environment.acr_name
}

output "acr_id" {
  value = module.environment.acr_id
}

output "rg_name" {
  value = module.environment.rg_name
}

output "network_name" {
  value = module.environment.network_name
}