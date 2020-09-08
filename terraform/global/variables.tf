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