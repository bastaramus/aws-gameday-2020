###
# LB for demo project, prod snipeit
###

# Bucket for logs

module "log_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 1.0"

  bucket                         = "alb-logs-123456789devx"
  acl                            = "log-delivery-write"
  force_destroy                  = true
  attach_elb_log_delivery_policy = true

  tags = {
    Terraform   = "true"
  }

}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = "alb-unicorn"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = ["${aws_security_group.LB_public_sg.id}"]

  target_groups = [
    {
      name_prefix      = "web-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      target_group_index = 0
    }
  ]


  tags = {
    Terraform   = "true"
  }
}