provider "kubernetes" {
  config_path    = "~/.kube/config"
}
# Specify the Helm provider
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  # Path to your Kubernetes configuration file
  }
}


resource "kubernetes_namespace" "kasten-io" {
  metadata {
    name = "kasten-io"
  }
}
resource "kubernetes_service_account" "my-kasten-sa" {
  metadata {
    name = "my-kasten-sa"
    namespace = "kasten-io"
  }
}
# Install a Helm chart
resource "helm_release" "kasten" {
  name       = "k10"  # The name for your Helm release
  repository = "https://charts.kasten.io/"  # URL of the Helm chart repository
  namespace  = kubernetes_namespace.example_namespace.metadata[0].name
  chart      = "kasten"  # The name of the Helm chart to install
  set {
    name  = "ingress.create"
    value = "true"
  }
  set {
    name  = "ingress.class"
    value = "nginx"
  }

  set {
    name  = "auth.tokenAuth.enabled"
    value = "true"
  }

}