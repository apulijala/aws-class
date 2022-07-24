resource "aws_autoscaling_group" "autoscaling" {

  name                      = var.asg_name
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = 300
  health_check_type         = var.health_check_type
  desired_capacity          = var.asg_des_capacity
  # target_group_arns = []

  launch_template {
    id = aws_launch_template.launch_template.id
    name = aws_launch_template.launch_template.name
  }
  vpc_zone_identifier       = [ aws_security_group.allow_ssh_http.id ]
  tag {
    key                 = "Name"
    value               = var.asg_name
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

}