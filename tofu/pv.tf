# pv.tf - Configures Kubernetes Persistent Volumes for Harbor

# Create a Kubernetes storage class for EFS
resource "kubernetes_storage_class" "efs" {
  metadata {
    name = "efs-sc-${var.cluster_name}"
  }
  storage_provisioner = "efs.csi.aws.com"
  depends_on = [
    helm_release.aws_efs_csi_driver
  ]
}

# Create a Kubernetes persistent volume for Harbor
resource "kubernetes_persistent_volume" "harbor" {
  metadata {
    name = "harbor-efs-${var.cluster_name}"
    labels = {
      type = "efs"
    }
  }
  spec {
    storage_class_name = "efs-sc-${var.cluster_name}"
    claim_ref {
      name      = "pvc-harbor-efs-${var.cluster_name}"
      namespace = "default"
    }
    capacity = {
      storage = "10Gi"
    }
    volume_mode                      = "Filesystem"
    persistent_volume_reclaim_policy = "Retain"
    access_modes                     = ["ReadWriteMany"]
    persistent_volume_source {
      csi {
        driver        = "efs.csi.aws.com"
        volume_handle = "${aws_efs_file_system.harbor.id}::${aws_efs_access_point.harbor.id}"
      }
    }
  }
  depends_on = [
    kubernetes_storage_class.efs,
    aws_vpc_security_group_ingress_rule.eks-default
  ]
}

# Create a Kubernetes persistent volume claim for Harbor
resource "kubernetes_persistent_volume_claim" "harbor" {
  metadata {
    name      = "pvc-harbor-efs-${var.cluster_name}"
    namespace = "default"
  }

  spec {
    storage_class_name = "efs-sc-${var.cluster_name}"
    volume_name        = "harbor-efs-${var.cluster_name}"
    access_modes       = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }

  depends_on = [
    kubernetes_persistent_volume.harbor
  ]
}