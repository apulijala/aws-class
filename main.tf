provider "aws" {
  region = "eu-west-2"
  # allowed_account_ids = [ ""  ]
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


module "vm_instance" {
  source         = "./vm_instance"
  instance_name  = var.instance_name
  instance_type  = var.instance_type
  ami            = var.ami
  sec_group_name = var.sec_group_name
  key_name       = var.key_name
  subnet_id = data.aws_subnets.default_subnets.ids[0]
  vpc_id = data.aws_vpc.default.id
}
