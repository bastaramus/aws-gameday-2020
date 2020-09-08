terraform {
  required_version = "~> 0.13.2"

  backend "s3" {
    bucket               = "gameday-tfstate-storage-v1"
    dynamodb_table       = "gameday-tf-lock-table"
    encrypt              = true
    key                  = "global/terraform.tfstate"
    region               = "eu-central-1"
    workspace_key_prefix = "gameday"
  }
}