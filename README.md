# VPC terraform module for GitLab CI on AWS

Creates vpc, subnets, gateways and security groups for GitLab CI deployment on AWS

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.5 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.14 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | The name of used environment | `string` | n/a | yes |
| gitlab\_public\_ssh\_key | Public part of ssh key pair for access to instances | `string` | `"ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAqk+k1HXWuUUJw2MFipf35QRUpyOCBCIp/d2/F1drQbgrNwn9ZMgd3tjLLTDRPzD9+kNOkzbxpgXyfG0ukyrG9ovYj3e+Oc/1C36swFn9Zr5fxCC41yznr5axo0O/r0vZ9vH5BfIPGc5XNgXygnHiY7nFdWvoZcRQridjkRZqMuU= igortiunov@gmail.com"` | no |
| vpc\_availability\_zones | The list of azs used for deployment | `list(string)` | n/a | yes |
| vpc\_cidr | The cidr for vpc subnets | `string` | n/a | yes |
| vpc\_database\_subnets | The list of database subnets | `list(string)` | n/a | yes |
| vpc\_elasticache\_subnets | The list of redis subnets | `list(string)` | n/a | yes |
| vpc\_private\_subnets | The list of private subnets | `list(string)` | n/a | yes |
| vpc\_public\_subnets | The list of public subnets | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| gitlab\_availability\_zones | The list of availability zones for deployment |
| gitlab\_bastion\_sg\_ids | List of SGs IDs for bastion instance |
| gitlab\_elasticache\_subnet\_group\_name | ElastiCache subnet group name |
| gitlab\_gitaly\_sg\_ids | List of SGs IDs for gitaly instances |
| gitlab\_keypair | Key pair name for infra tasks |
| gitlab\_lb\_sg\_ids | List of SGs IDs for app instances |
| gitlab\_private\_subnets | List of private subnets |
| gitlab\_public\_subnets | List of public subnets |
| gitlab\_rds\_sg\_ids | List of SGs IDs for rds db instance |
| gitlab\_rds\_subnet\_ids | List of SGs IDs for rds db instance |
| gitlab\_redis\_sg\_ids | List of SGs IDs for redis instance |
| gitlab\_runner\_sg\_ids | List of SGs IDs for runner instances |
| vpc\_id | The ID of the VPC |
