resource "helm_release" "argo" {
  name = "argocd"

  chart            = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  version          = "3.35.4"
  namespace        = "argocd"
  create_namespace = true

  values = [file("values/default.yaml")]

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
}
