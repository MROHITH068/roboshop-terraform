#module "instances" {
#  for_each = var.component
#  component= each.key
#  source = "git::https://github.com/MROHITH068/terraform-module-app.git"
#  env=var.env
#  tags= merge(each.value["tags"], var.tags)
#}

module "vpc" {
  source = "git::https://github.com/MROHITH068/terraform-module-vpc.git"

  for_each = var.vpc
  cidr_block = each.value["cidr_block"]
  subnets = each.value["subnets"]
  env = var.env
  tags = var.tags
  default_vpc_id = var.default_vpc_id
}