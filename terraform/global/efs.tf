resource "aws_efs_file_system" "unicorn_efs" {
  creation_token   = "unicorn_efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = {
    Terraform   = "true"
    Project     = "Unicorn"
  }
}

resource "aws_efs_mount_target" "unicorn_efs_mt" {
  count           = length(module.vpc.private_subnets)
  file_system_id  = aws_efs_file_system.unicorn_efs.id
  subnet_id       = element(module.vpc.private_subnets, count.index)
  security_groups = ["${aws_security_group.efs_sg.id}"]
}