resource "aws_security_group" "myrds_sg" {
  vpc_id = var.vpc_id

}


resource "aws_db_instance" "mysql_rds" {

  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "wordpressdb"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids = []

}