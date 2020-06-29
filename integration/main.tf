provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "eu-west-1"
}

variable "access_key" { type = string }
variable "secret_key" { type = string }

module "help" {
  source  = "../"
  os = module.help.AMAZON_LINUX_2
}

data "aws_ami" "all" {
  for_each = module.help.filters

  most_recent = true
  owners      = each.value.owners

  dynamic "filter" {
    for_each = each.value.filters
    content {
      name   = filter.value.name
      values = filter.value.values
    }
  }
}

output "amis" {
  value = values(data.aws_ami.all)[*].name
}

output "ami" {
  value = module.help.ami_id
}
