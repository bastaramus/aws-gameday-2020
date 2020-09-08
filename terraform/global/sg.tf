###
# Security group for web server
###


resource "aws_security_group" "webserver_ec2" {
  name        = "webserver_ec2"
  description = "Access to ec2 instance"
  vpc_id      = module.vpc.vpc_id

  #SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  #HTTP
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.LB_public_sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

###
# Public security group for LB
###

resource "aws_security_group" "LB_public_sg" {
  name        = "LB_public_sg"
  description = "Used for the elb for public access"
  vpc_id      = module.vpc.vpc_id

  #HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

###
# RDS security group
###

resource "aws_security_group" "DB_rds_sg" {
  name        = "DB_rds_sg"
  description = "Used for RDS instances"
  vpc_id      = module.vpc.vpc_id

  #SQL access from "Demo project" security group
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.webserver_ec2.id}"]
  }
}