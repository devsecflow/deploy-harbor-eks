# harbor.tf - Deploys Harbor using Helm

resource "helm_release" "harbor" {
  name       = "my-release-${var.cluster_name}"
  repository = "https://helm.goharbor.io"
  chart      = "harbor"

  # Use a template file for Harbor values
  values = [templatefile("harbor-values-template.yaml", {
    cert_arn     = var.cert_arn,
    domain_name  = var.domain_name,
    db_host      = module.db.db_instance_address,
    db_password  = local.db_password,
    cluster_name = var.cluster_name
  })]

  depends_on = [
    module.eks,
    module.alb_controller,
    kubernetes_persistent_volume_claim.harbor,
    aws_vpc_security_group_ingress_rule.eks-default
  ]
}