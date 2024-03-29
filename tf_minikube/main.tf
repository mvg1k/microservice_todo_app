provider "kubernetes" {
  config_context_cluster   = "minikube"
  config_path = "~/.kube/config"
}


resource "kubernetes_namespace" "prod_namespace" {
  metadata {
    name = "prod"
  }
}