variable "environment" {
  description = "The name of used environment"
  type        = string
}

variable "vpc_cidr" {
  description = "The cidr for vpc subnets"
  type        = string
}

variable "vpc_availability_zones" {
  description = "The list of azs used for deployment"
  type        = list(string)
}

variable "vpc_public_subnets" {
  description = "The list of public subnets"
  type        = list(string)
}

variable "vpc_private_subnets" {
  description = "The list of private subnets"
  type        = list(string)
}

variable "vpc_database_subnets" {
  description = "The list of database subnets"
  type        = list(string)
}

variable "vpc_elasticache_subnets" {
  description = "The list of redis subnets"
  type        = list(string)
}
