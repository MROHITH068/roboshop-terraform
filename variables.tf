variable "env" {}
#variable "component" {}
variable "tags" {}
variable "vpc" {}

variable "default_vpc_id" {}
variable "default_vpc_rt" {}
variable "rabbitmq" {}
variable "allow_ssh_cidr" {}
variable "zone_id" {}

variable "rds" {}
variable "kms_key_arn" {}
variable "kms_key_id" {}

variable "documentdb" {}
variable "elasticache" {}
variable "alb" {}
variable "apps" {}
variable "lb_dns_name" {}