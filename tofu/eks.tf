# eks.tf - Configures the Amazon EKS cluster

module "eks" {
  source                         = "terraform-aws-modules/eks/aws"
  version                        = "19.16.0"
  cluster_name                   = var.cluster_name
  cluster_version                = "1.30"
  cluster_endpoint_public_access = true
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_enabled_log_types      = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  # Configure the EKS managed node group
  eks_managed_node_groups = {
    "${var.cluster_name}-node" = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = [var.node_instance_type]
      min_size       = 1
      max_size       = 1
      desired_size   = 1
    }
  }

  # Disable the creation of the aws-auth configmap
  manage_aws_auth_configmap = false
}

# Output the IAM role ARN for the EKS managed node group
output "eks_managed_node_groups_iam_role_arn" {
  description = "IAM role ARN for EKS managed node group"
  value       = module.eks.eks_managed_node_groups["${var.cluster_name}-node"].iam_role_arn
}