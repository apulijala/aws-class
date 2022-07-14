resource "aws_security_group_rule" "open_traffic_from_instance" {

  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
  type = "egress"
  security_group_id = aws_security_group.db_security_group.id

}

resource "aws_security_group" "db_security_group" {

  name        = var.db_sec_group_name
  description = "Allow traffic into database from instance"
  vpc_id      = var.vpc_id
  tags = {
    Name = var.db_sec_group_name
  }

}

resource "aws_db_instance" "mysql_rds" {

  allow_major_version_upgrade = false
  auto_minor_version_upgrade = false
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "wordpressdb"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.db_security_group.id]

}