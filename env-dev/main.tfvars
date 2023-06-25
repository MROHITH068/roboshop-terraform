env="dev"

component = {
  frontend = {
    tags: {"Monitor": "true","env": "dev"}
  }
  mongodb = {
    tags: { "env": "dev"}
  }
  catalogue = {
    tags: {"Monitor": "true","env": "dev"}
  }
  cart = {
    tags: {"Monitor": "true","env": "dev"}
  }
  redis = {
    tags: {"env": "dev"}
  }
  user = {
    tags: {"Monitor": "true","env": "dev"}
  }
  mysql = {
    tags: {"env": "dev"}
  }
  payment = {
    tags: {"Monitor": "true","env": "dev"}
  }
  rabbitmq = {
    tags: {"env": "dev"}
  }
  shipping = {
    tags: {"Monitor": "true","env": "dev"}
  }
}

tags = {
  company_name = "XYZ Tech"
  business = "ecommerce"
  project_name= "roboshop"
}
