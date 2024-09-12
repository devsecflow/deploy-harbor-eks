# rds.tf - Configures the Amazon RDS instance for Harbor

module "db" {
  source                                = "terraform-aws-modules/rds/aws"
  version                               = "6.1.1"
  identifier                            = "harbordb-${var.cluster_name}"
  engine                                = "postgres"
  engine_version                        = "16.3"
  family                                = "postgres16"
  subnet_ids                            = module.vpc.private_subnets
  vpc_security_group_ids                = [module.vpc.default_security_group_id]
  create_db_subnet_group                = true
  instance_class                        = "db.t3.micro"
  password                              = var.db_password
  allocated_storage                     = 5
  username                              = "postgres"
  db_name                               = "postgres"
  manage_master_user_password           = false
  deletion_protection                   = true
  performance_insights_enabled          = true
  performance_insights_retention_period = 7 # 7 days retention
}