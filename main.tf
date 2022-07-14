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

module "rds_database" {
  source = "./rds_database"
  db_sec_group_name = var.db_sec_group_name
  vpc_id = data.aws_vpc.default.id


}

data "template_file" "db_install" {

  template = "${file("${path.module}/install_db.sh")}"
  vars = {
    db_host = "${module.rds_database.rds_database_endpoint}"
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
  user_data = data.template_file.db_install.rendered
}

resource "aws_security_group_rule" "allow_traffic_from_instance_to_db" {

  from_port = 0
  protocol = "-1"
  security_group_id = module.rds_database.rds_sg_id
  source_security_group_id = module.vm_instance.lamp_sec_group_id
  to_port = 0
  type = "ingress"
}
