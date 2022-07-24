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



resource "aws_launch_template" "launch_template" {

  name = var.name
  cpu_options {
    core_count = 4
    threads_per_core = 2
  }
  credit_specification {
    cpu_credits = "standard"
  }
  ebs_optimized = true
  image_id = var.ami
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = var.instance_type
  key_name = var.key_name

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags = "enabled"
  }

  network_interfaces {
    associate_public_ip_address = true
  }
  placement {
    availability_zone = var.availability_zone
  }
  vpc_security_group_ids = [ aws_security_group.allow_ssh_http.id ]
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "test"
    }
  }

  user_data = var.user_data
}