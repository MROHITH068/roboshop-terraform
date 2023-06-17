module "test" {
  for_each = var.component
  component= each.key
  source = "git::https://github.com/MROHITH068/terraform-module-app.git"
  env=var.env
}