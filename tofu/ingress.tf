# ingress.tf - Configures the AWS Load Balancer Controller

# Install the AWS Load Balancer Controller using a module
module "alb_controller" {
  source                           = "lablabs/eks-load-balancer-controller/aws"
  version                          = "1.3.0"
  cluster_name                     = var.cluster_name
  irsa_role_name_prefix            = var.cluster_name
  cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn
  cluster_identity_oidc_issuer     = module.eks.cluster_oidc_issuer_url
}