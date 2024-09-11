# vpc.tf - Configures the Amazon VPC for the EKS cluster

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.13"

  # VPC Configuration
  name = "harbor-vpc-${var.cluster_name}"
  cidr = var.vpc_cidr

  # Availability Zones and Subnets
  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = [cidrsubnet(var.vpc_cidr, 4, 1), cidrsubnet(var.vpc_cidr, 4, 2)]
  public_subnets  = [cidrsubnet(var.vpc_cidr, 4, 4), cidrsubnet(var.vpc_cidr, 4, 5)]

  # NAT Gateway and DNS Settings
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  # Tags for the VPC
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  # Tags for Public Subnets
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

  # Tags for Private Subnets
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}