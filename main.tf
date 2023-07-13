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
  default_vpc_rt = var.default_vpc_rt
}


module "app_server" {
  component= "test"
  source = "git::https://github.com/MROHITH068/terraform-module-app.git"
  tags= var.tags
  env = var.env
  vpc_id= lookup(lookup(module.vpc, "main", null),"vpc_id",null)
  subnet_id = lookup(lookup(lookup(lookup(module.vpc, "main", null ),"subnet_ids",null),"app",null),"subnet_ids",null)[0]
}

module "rabbitmq"{
  source = "git::https://github.com/MROHITH068/terraform-module-rabbitmq.git"
  for_each = var.rabbitmq
  component = each.value["component"]
  instance_type = each.value["instance_type"]

  sg_subnet_cidr = lookup(lookup(lookup(lookup(var.vpc, "main", null ),"subnets",null),"app",null),"cidr_block",null)
  vpc_id= lookup(lookup(module.vpc, "main", null),"vpc_id",null)
  subnet_id = lookup(lookup(lookup(lookup(module.vpc, "main", null ),"subnet_ids",null),"db",null),"subnet_ids",null)[0]

  tags= var.tags
  env = var.env
  allow_ssh_cidr = var.allow_ssh_cidr
}