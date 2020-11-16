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

variable "gitlab_public_ssh_key" {
  description = "Public part of ssh key pair for access to instances"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAqk+k1HXWuUUJw2MFipf35QRUpyOCBCIp/d2/F1drQbgrNwn9ZMgd3tjLLTDRPzD9+kNOkzbxpgXyfG0ukyrG9ovYj3e+Oc/1C36swFn9Zr5fxCC41yznr5axo0O/r0vZ9vH5BfIPGc5XNgXygnHiY7nFdWvoZcRQridjkRZqMuU= igortiunov@gmail.com"
  type        = string
}
