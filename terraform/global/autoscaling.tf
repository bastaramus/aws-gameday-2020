# ------------ launch configuration ----------

resource "aws_launch_configuration" "unicorn_lc" {
  name_prefix          = "unicorn_lc-"
  image_id             = data.aws_ami.packer-unicorn.id
  instance_type        = var.lc_instance_type
  security_groups      = ["${aws_security_group.webserver_ec2.id}"]
  key_name             = aws_key_pair.ssh_auth.id

  lifecycle {
    create_before_destroy = true
  }

}

# -------- ASG ----------

resource "aws_autoscaling_group" "snipeit_asg" {
  name                      = "asg-${aws_launch_configuration.unicorn_lc.id}"
  max_size                  = var.asg_max
  min_size                  = var.asg_min
  health_check_grace_period = var.asg_grace
  health_check_type         = var.asg_hct
  desired_capacity          = var.asg_cap
  force_delete              = true
  target_group_arns         = module.alb.target_group_arns

  vpc_zone_identifier = module.vpc.private_subnets

  launch_configuration = aws_launch_configuration.unicorn_lc.name

  tag {
    key                 = "Name"
    value               = "unicorn-web-server"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "Unicorn"
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    delete = "15m"
  }

}