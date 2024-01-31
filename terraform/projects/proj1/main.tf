module "proj" {
  source = "../../workspaces/stack_aks_cosmo"

  aks_cluster_name = "proj1-dev-aks"
  env_type         = "dev"
}