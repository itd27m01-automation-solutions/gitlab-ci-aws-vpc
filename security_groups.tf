module "gitlab_lb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.16.0"

  name        = "gitlab-loadbalancer-sec-group"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = module.vpc.vpc_id

  # NOTE(igortiunov): dont work fo some reason
  # ingress_rules = ["https-443-tcp", "ssh-22-tcp"]

  # TODO: Are egress rules needed?
  ingress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "HTTPS access to gilab front"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH access to gilab front"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 8
      to_port     = 0
      protocol    = "icmp"
      description = "ICMP access to gilab front"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "Egress traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

module "gitlab_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.16.0"

  name        = "bastion-sec-group"
  description = "Security group access to bastion hosts"
  vpc_id      = module.vpc.vpc_id

  # NOTE(igortiunov): doesn't work fo some reason
  # ingress_rules = ["ssh-22-tcp"]

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH access to gilab front"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 8
      to_port     = 0
      protocol    = "icmp"
      description = "ICMP access to gilab"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "Egress traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

module "gitlab_gitaly_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.16.0"

  name        = "gitlab-gitaly-sec-group"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port                = 8075
      to_port                  = 8075
      protocol                 = "tcp"
      description              = "gitally access from application servers"
      source_security_group_id = module.gitlab_lb_sg.this_security_group_id
    },
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      description              = "SSH access from bastion hosts"
      source_security_group_id = module.gitlab_bastion_sg.this_security_group_id
    },
    {
      from_port                = 8
      to_port                  = 0
      protocol                 = "icmp"
      description              = "ICMP access to gilab"
      source_security_group_id = module.gitlab_bastion_sg.this_security_group_id
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "Egress traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

module "gitlab_runner_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.16.0"

  name        = "gitlab-runner-sec-group"
  description = "Security group for runners instances"
  vpc_id      = module.vpc.vpc_id

  # TODO: Update rules for runner instances
  ingress_with_source_security_group_id = [
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      description              = "SSH access from bastion hosts"
      source_security_group_id = module.gitlab_bastion_sg.this_security_group_id
    },
    {
      from_port                = 8
      to_port                  = 0
      protocol                 = "icmp"
      description              = "ICMP access to gilab"
      source_security_group_id = module.gitlab_bastion_sg.this_security_group_id
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "Egress traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

module "gitlab_rds_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.16.0"

  name        = "gitlab-rds-sec-group"
  description = "Security group for rds service"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "postgresql-tcp"
      source_security_group_id = module.gitlab_lb_sg.this_security_group_id
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "Egress traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

module "gitlab_redis_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.16.0"

  name        = "gitlab-redis-sec-group"
  description = "Security group for redis service"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port                = 6379
      to_port                  = 6379
      protocol                 = "tcp"
      description              = "Access to redis from app instances"
      source_security_group_id = module.gitlab_lb_sg.this_security_group_id
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "Egress traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}