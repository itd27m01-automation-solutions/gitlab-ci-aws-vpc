module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  name = var.environment
  cidr = var.vpc_cidr

  azs                 = var.vpc_availability_zones
  public_subnets      = var.vpc_public_subnets
  private_subnets     = var.vpc_private_subnets
  database_subnets    = var.vpc_database_subnets
  elasticache_subnets = var.vpc_elasticache_subnets

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  create_database_subnet_group    = true
  create_elasticache_subnet_group = true

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
