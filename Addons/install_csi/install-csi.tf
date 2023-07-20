# Specify the Helm provider
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  # Path to your Kubernetes configuration file
  }
}

# Install a Helm chart
resource "helm_release" "zadara-csi" {
  name       = "zadara-csi-helm"  # The name for your Helm release
  repository = "https://raw.githubusercontent.com/zadarastorage/zadara-csi/release/zadara-csi-helm"  # URL of the Helm chart repository

  chart      = "zadara-csi"  # The name of the Helm chart to install

}

# Install a Helm chart
resource "helm_release" "zadara-csi-crds" {
  name       = "csi-snapshots-v1"  # The name for your Helm release
  repository = "https://raw.githubusercontent.com/zadarastorage/zadara-csi/release/zadara-csi-helm"  # URL of the Helm chart repository

  chart      = "snapshots-v1"  # The name of the Helm chart to install

}