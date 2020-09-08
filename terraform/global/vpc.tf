module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  enable_dns_hostnames = true
  enable_dns_support   = true

  name = "unicor_vpc"
  cidr = var.vpc_cidr

  azs              = var.vpc_available_zones
  private_subnets  = var.vpc_private_subnets
  intra_subnets    = var.vpc_intra_subnets
  public_subnets   = var.vpc_public_subnets
  database_subnets = var.vpc_db_subnets

  public_subnet_suffix  = "public"
  intra_subnet_suffix   = "intra"
  private_subnet_suffix = "private"


  create_database_subnet_group = true

  intra_subnet_tags = {
    Name = "intra_subnet"
  }

  public_subnet_tags = {
    Name = "public_subnet"
  }
  private_subnet_tags = {
    Name = "private_subnet"
  }
  database_subnet_tags = {
    Name = "db_subnet"
  }

  public_route_table_tags = {
    Name = "public_rt"
  }
  private_route_table_tags = {
    Name = "private_rt"
  }
  database_route_table_tags = {
    Name = "db_rt"
  }

  tags = {
    Terraform = "true"
    Project   = "Unicor"
  }
}