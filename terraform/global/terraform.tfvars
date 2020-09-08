aws_region = "us-west-2"

vpc_cidr            = "10.0.0.0/16"
vpc_available_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
vpc_public_subnets  = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
vpc_private_subnets = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
vpc_intra_subnets   = ["10.0.41.0/24", "10.0.42.0/24", "10.0.43.0/24"]
vpc_db_subnets      = ["10.0.31.0/24", "10.0.32.0/24", "10.0.33.0/24"]

db_name             = "unicor"
db_username         = "dbuser"
db_password         = "HvSGTNyWf3ec2p"

lc_instance_type    = "t2.medium"

asg_max             = "6"
asg_min             = "2"
asg_grace           = "120"
asg_hct             = "ELB"
asg_cap             = "2"