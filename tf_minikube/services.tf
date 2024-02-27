resource "kubernetes_service" "nginx_service" {
 metadata {
   name = "nginx-service"
 }
 spec {
   selector = {
     test = "My_nginx_pod"
   }
   port {
     port      = 30001
     target_port = 80
   }
   type = "NodePort"
 }
}