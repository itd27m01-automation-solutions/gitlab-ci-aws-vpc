output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "gitlab_availability_zones" {
  description = "The list of availability zones for deployment"
  value       = module.vpc.azs
}

output "gitlab_rds_sg_ids" {
  description = "List of SGs IDs for rds db instance"
  value       = [module.gitlab_rds_sg.this_security_group_id]
}

output "gitlab_rds_subnet_ids" {
  description = "List of SGs IDs for rds db instance"
  value       = module.vpc.database_subnets
}

output "gitlab_redis_sg_ids" {
  description = "List of SGs IDs for redis instance"
  value       = [module.gitlab_redis_sg.this_security_group_id]
}

output "gitlab_elasticache_subnet_group_name" {
  description = "ElastiCache subnet group name"
  value       = module.vpc.elasticache_subnet_group_name
}

output "gitlab_private_subnets" {
  description = "List of private subnets"
  value       = module.vpc.private_subnets
}

output "gitlab_public_subnets" {
  description = "List of public subnets"
  value       = module.vpc.public_subnets
}

output "gitlab_lb_sg_ids" {
  description = "List of SGs IDs for app instances"
  value       = [module.gitlab_lb_sg.this_security_group_id]
}

output "gitlab_gitaly_sg_ids" {
  description = "List of SGs IDs for gitaly instances"
  value       = [module.gitlab_gitaly_sg.this_security_group_id]
}

output "gitlab_runner_sg_ids" {
  description = "List of SGs IDs for runner instances"
  value       = [module.gitlab_runner_sg.this_security_group_id]
}

output "gitlab_bastion_sg_ids" {
  description = "List of SGs IDs for bastion instance"
  value       = [module.gitlab_bastion_sg.this_security_group_id]
}
