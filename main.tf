provider "kubernetes" {
  config_context_cluster   = "minikube"
  config_path = "~/.kube/config"
}

#namespace
resource "kubernetes_namespace" "prod_namespace" {
  metadata {
    name = "prod"
  }
}