# sg.tf - Configures Security Group rules for EKS

# Allow ingress from EKS cluster security group to VPC default security group
resource "aws_vpc_security_group_ingress_rule" "eks-default" {
  security_group_id            = module.vpc.default_security_group_id
  referenced_security_group_id = module.eks.cluster_security_group_id
  ip_protocol                  = "-1"
}

# Allow ingress from EKS node security group to VPC default security group
resource "aws_vpc_security_group_ingress_rule" "eks-node-default" {
  security_group_id            = module.vpc.default_security_group_id
  referenced_security_group_id = module.eks.node_security_group_id
  ip_protocol                  = "-1"
}