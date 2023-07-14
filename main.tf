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


#module "app_server" {
#  component= "test"
#  source = "git::https://github.com/MROHITH068/terraform-module-app.git"
#  tags= var.tags
#  env = var.env
#  vpc_id= lookup(lookup(module.vpc, "main", null),"vpc_id",null)
#  subnet_id = lookup(lookup(lookup(lookup(module.vpc, "main", null ),"subnet_ids",null),"app",null),"subnet_ids",null)[0]
#}
#
#module "rabbitmq"{
#  source = "git::https://github.com/MROHITH068/terraform-module-rabbitmq.git"
#  for_each = var.rabbitmq
#  component = each.value["component"]
#  instance_type = each.value["instance_type"]
#
#  sg_subnet_cidr = lookup(lookup(lookup(lookup(var.vpc, "main", null ),"subnets",null),"app",null),"cidr_block",null)
#  vpc_id= lookup(lookup(module.vpc, "main", null),"vpc_id",null)
#  subnet_id = lookup(lookup(lookup(lookup(module.vpc, "main", null ),"subnet_ids",null),"db",null),"subnet_ids",null)[0]
#
#  tags= var.tags
#  env = var.env
#  zone_id = var.zone_id
#  allow_ssh_cidr = var.allow_ssh_cidr
#  kms_key_id = var.kms_key_id
#}
#
#module "rds" {
#  source = "git::https://github.com/MROHITH068/terraform-module-rds.git"
#  for_each = var.rds
#  component = each.value["component"]
#  database_name = each.value["database_name"]
#  engine = each.value["engine"]
#  engine_version = each.value["engine_version"]
#  instance_class = each.value["instance_class"]
#  instance_count = each.value["instance_count"]
#
#  subnet_ids =  lookup(lookup(lookup(lookup(module.vpc, "main", null ),"subnet_ids",null),"db",null),"subnet_ids",null)
#  sg_subnet_cidr = lookup(lookup(lookup(lookup(var.vpc, "main", null ),"subnets",null),"app",null),"cidr_block",null)
#  vpc_id= lookup(lookup(module.vpc, "main", null),"vpc_id",null)
#
#  kms_key_arn = var.kms_key_arn
#  tags = var.tags
#  env = var.env
#}

module "documentdb" {
  source = "git::https://github.com/MROHITH068/terraform-module-documentdb.git"
  for_each = var.documentdb
  component = each.value["component"]
  engine = each.value["engine"]
  engine_version = each.value ["engine_version"]
  db_instance_count = each.value["db_instance_count"]
  instance_class = each.value["instance_class"]


subnet_ids =  lookup(lookup(lookup(lookup(module.vpc, "main", null ),"subnet_ids",null),"db",null),"subnet_ids",null)
  sg_subnet_cidr = lookup(lookup(lookup(lookup(var.vpc, "main", null ),"subnets",null),"app",null),"cidr_block",null)
  vpc_id= lookup(lookup(module.vpc, "main", null),"vpc_id",null)

  kms_key_arn = var.kms_key_arn
  tags = var.tags
  env = var.env
}

module "elasticache" {
  source = "git::https://github.com/MROHITH068/terraform-module-elasticache.git"
  for_each = var.elasticache
  component = each.value["component"]
  node_type = each.value["node_type"]
  replicas_per_node_group = each.value["replicas_per_node_group"]
  num_node_groups = each.value["num_node_groups"]
  engine = each.value["engine"]
  engine_version = each.value["engine_version"]

  subnet_ids =  lookup(lookup(lookup(lookup(module.vpc, "main", null ),"subnet_ids",null),"db",null),"subnet_ids",null)
  sg_subnet_cidr = lookup(lookup(lookup(lookup(var.vpc, "main", null ),"subnets",null),"app",null),"cidr_block",null)
  vpc_id= lookup(lookup(module.vpc, "main", null),"vpc_id",null)

  kms_key_arn = var.kms_key_arn
  tags = var.tags
  env = var.env
}