resource "kubernetes_pod" "nginx_pod" {
  metadata {
    name = "nginx-pod"
    labels = {
      test = "My_nginx_pod"
    }
  }

  spec {
    container {
      image = "mvg1k/nginx-custom-html"
      name  = "my-nginx"
    }
  }
}
