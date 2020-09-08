variable "aws_region" {}

variable "vpc_cidr" {}
variable "vpc_available_zones" {
  type = list
}
variable "vpc_public_subnets" {
  type = list
}

variable "vpc_intra_subnets" {
  type = list
}

variable "vpc_private_subnets" {
  type = list
}
variable "vpc_db_subnets" {
  type = list
}

variable "db_name" {}
variable "db_username" {}
variable "db_password" {}

data "aws_ami" "packer-unicorn" {
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "tag:Name"
    values = ["Packer-unicorn"]
  }

  most_recent = true
  owners      = ["self"]
}

variable "lc_instance_type" {}

variable "asg_max" {}
variable "asg_min" {}
variable "asg_grace" {}
variable "asg_hct" {}
variable "asg_cap" {}