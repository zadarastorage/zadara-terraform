variable "vpsa_hostname" {
  type        = string
  description = "Description of the variable"
}
variable "vpsa_token" {
  type        = string
  description = "Description of the variable"
}
# Define provider for Kubernetes
provider "kubernetes" {
  config_path = "~/.kube/config"  # Path to your Kubernetes configuration file
}

# Install the Zadara VPSA on the Kubernetes cluster
resource "kubernetes_manifest" "vsc_sc" {
  manifest = {
    apiVersion = "storage.zadara.com/v1"
    kind = "VSCStorageClass"
    metadata = {
        name = "vscstorageclass-vpsa"
    }
    spec = {
        displayName = "VSC Storage Class"
        isDefault = "true"
    }   
  }
}


# Install the Zadara VPSA on the Kubernetes cluster
resource "kubernetes_manifest" "vpsa" {
  manifest = {
    apiVersion = "storage.zadara.com/v1"
    kind = "VPSA"
    metadata = {
        name = "vpsa"
    }
    spec = {
        displayName = "My VPSA"
        hostname = var.vpsa_hostname
        token = var.vpsa_token
        VSCStorageClassName = "vscstorageclass-vpsa"
    }   
  }
}


# Install the Zadara CSI Operator on the Kubernetes cluster
resource "kubernetes_manifest" "storageclass" {
  manifest = {
    apiVersion = "storage.k8s.io/v1"
    kind = "StorageClass"
    metadata = {
        name = "zadara-csi-nas"
        annotations = {
            "storageclass.kubernetes.io/is-default-class" = "true"
        }
    }
    provisioner = "csi.zadara.com"
    reclaimPolicy = "Delete"
    allowVolumeExpansion = "true"
    parameters= {
        VSCStorageClassName = "vscstorageclass-sample"
    }    
  }
}

# Install the Zadara VPSA on the Kubernetes cluster
resource "kubernetes_manifest" "volumesnapshotclass" {
  manifest = {
    apiVersion = "snapshot.storage.k8s.io/v1"
    kind = "VolumeSnapshotClass"
    metadata = {
        name = "zadara-csi-snapshot-class"
        annotations = {
            "k10.kasten.io/is-snapshot-class" = "true"
        }
    }
    deletionPolicy= "Delete"
    driver = "csi.zadara.com"
  }
}