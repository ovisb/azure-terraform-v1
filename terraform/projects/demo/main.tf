module "proj" {
  source = "../../workspaces/stack_aks_cosmo"

  project_name = "demo"
  env_type     = "dev"
}

output "aks_cluster_name" {
  value = module.proj.kubernetes_cluster_name
}

output "aks_key_vault_id" {
  value = module.proj.aks_vault_id
}

output "endpoint" {
  value = module.proj.endpoint
}