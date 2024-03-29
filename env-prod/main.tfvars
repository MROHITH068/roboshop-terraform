env="prod"

#component = {
#  frontend = {
#    tags: {"Monitor": "true","env": "dev"}
#  }
#  mongodb = {
#    tags: { "env": "dev"}
#  }
#  catalogue = {
#    tags: {"Monitor": "true","env": "dev"}
#  }
#  cart = {
#    tags: {"Monitor": "true","env": "dev"}
#  }
#  redis = {
#    tags: {"env": "dev"}
#  }
#  user = {
#    tags: {"Monitor": "true","env": "dev"}
#  }
#  mysql = {
#    tags: {"env": "dev"}
#  }
#  payment = {
#    tags: {"Monitor": "true","env": "dev"}
#  }
#  rabbitmq = {
#    tags: {"env": "dev"}
#  }
#  shipping = {
#    tags: {"Monitor": "true","env": "dev"}
#  }
#}

tags = {
  company_name  = "XYZ Tech"
  business      = "ecommerce"
  business_unit = "retail"
  cost_center   = "322"
  project_name  = "roboshop"
}

vpc = {
  main = {
    cidr_block = "10.10.0.0/16"
    subnets = {
      web = {
        cidr_block = ["10.10.0.0/24","10.10.1.0/24"]
      }
      app = {
        cidr_block = ["10.10.2.0/24","10.10.3.0/24"]
      }
      db = {
        cidr_block = ["10.10.4.0/24","10.10.5.0/24"]
      }
      public = {
        cidr_block = ["10.10.6.0/24","10.10.7.0/24"]
      }
    }
  }
}

default_vpc_id = "vpc-0f76447f54508b96c"
default_vpc_rt = "rtb-07a60386a48104a7b"
allow_ssh_cidr = [ "172.31.8.139/32" ]
zone_id = "Z01893031FJEHFT2WJCRK"
allow_prometheus_cidr = ["172.31.83.129/32"]
kms_key_id = "8dd96880-9b44-4bb8-b1f2-1f5940d93f11"
kms_key_arn = "arn:aws:kms:us-east-1:403215663985:key/8dd96880-9b44-4bb8-b1f2-1f5940d93f11"

rabbitmq = {
  main = {
    instance_type = "t3.small"
    component = "rabbitmq"
  }
}

rds = {
  main = {
    component = "rds"
    engine         = "aurora-mysql"
    engine_version = "5.7.mysql_aurora.2.11.3"
    database_name = "dummy"
    instance_count = 1
    instance_class = "db.t3.medium"
  }
}

documentdb = {
  main = {
    component = "docdb"
     engine = "docdb"
     engine_version = "4.0.0"
     db_instance_count = 1
     instance_class = "db.t3.medium"
  }
}

elasticache = {
  main = {
    component = "elasticache"
    engine = "redis"
    engine_version = "6.x"
    node_type = "cache.t3.small"
    replicas_per_node_group = 1
    num_node_groups = 1
  }
}

alb = {
  public = {
    name               = "public"
    internal           = false
    load_balancer_type = "application"
    subnet_ref         = "public"
  }
  private = {
    name               = "private"
    internal           = true
    load_balancer_type = "application"
    subnet_ref         = "app"
  }
}

apps = {
  cart ={
    component = "cart"
    app_port = 8080
    instance_type = "t3.micro"
    desired_capacity = 1
    max_size = 5
    min_size = 1
    subnet_ref = "app"
    lb_ref = "private"
    lb_rule_priority = 101
  }
  catalogue ={
    component = "catalogue"
    app_port = 8080
    instance_type = "t3.small"
    desired_capacity = 1
    max_size = 5
    min_size = 1
    subnet_ref = "app"
    lb_ref = "private"
    lb_rule_priority = 102
    extra_param_access = ["arn:aws:ssm:us-east-1:403215663985:parameter/roboshop.prod.docdb.*"]
  }
  shipping ={
    component = "shipping"
    app_port = 8080
    instance_type = "t3.small"
    desired_capacity = 1
    max_size = 5
    min_size = 1
    subnet_ref = "app"
    lb_ref = "private"
    lb_rule_priority = 103
    extra_param_access = ["arn:aws:ssm:us-east-1:403215663985:parameter/roboshop.prod.mysql.*"]
  }
  payment ={
    component = "payment"
    app_port = 8080
    instance_type = "t3.small"
    desired_capacity = 1
    max_size = 5
    min_size = 1
    subnet_ref = "app"
    lb_ref = "private"
    lb_rule_priority = 104
  }
  user ={
    component = "user"
    app_port = 8080
    instance_type = "t3.small"
    desired_capacity = 1
    max_size = 5
    min_size = 1
    subnet_ref = "app"
    lb_ref = "private"
    lb_rule_priority = 105
    extra_param_access = ["arn:aws:ssm:us-east-1:403215663985:parameter/roboshop.prod.docdb.*"]
  }
  frontend ={
    component = "frontend"
    app_port = 80
    instance_type = "t3.small"
    desired_capacity = 1
    max_size = 5
    min_size = 1
    subnet_ref = "web"
    lb_ref = "public"
    lb_rule_priority = 100
  }
}

eks ={
  main ={
    subnet_ref = "app"
    min_size = 2
    max_size= 2
    capacity_type = "SPOT"
    instance_type = ["t3.xlarge","t3.large","t3.medium"]
  }
}