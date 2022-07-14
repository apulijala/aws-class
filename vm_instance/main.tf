#. I need a security group.

resource "aws_security_group" "allow_ssh_http" {

  name        = var.sec_group_name
  description = "Allow SSH traffic and web traffic"
  vpc_id      = var.vpc_id
  tags = {
    Name = var.sec_group_name
  }
}

resource "aws_security_group_rule" "ssh_rule" {

  from_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.allow_ssh_http.id
  to_port = 22
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "http_rule" {

  from_port = 80
  protocol = "tcp"
  security_group_id = aws_security_group.allow_ssh_http.id
  to_port = 80
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "open_external_traffic" {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_ssh_http.id
  type = "egress"
}

# Resource for the instance.
resource "aws_instance" "lamp_web_server"  {

  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = [ aws_security_group.allow_ssh_http.id ]
  user_data = var.user_data

}

# Finally execute a shell script to do my work.

