/****************************************
*************** INIT ********************
*****************************************/

resource "aws_dynamodb_table" "gameday_tf_lock_table" {
  name			= "gameday-tf-lock-table"
  read_capacity		= 20
  write_capacity	= 20
  hash_key		= "LockID"

  attribute {
    name		= "LockID"
    type		= "S"
  }

  tags = {
    Name = "DynamoDB Terraform State Lock Table"
    Project         = "Gameday"
  }
}

resource "aws_s3_bucket" "gameday-tfstate-storage-v1" {
  acl			= "private"
  bucket		= "gameday-tfstate-storage-v1"

  versioning {
    enabled		= true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "Gameday S3 Remote Terraform State Store"   
    Project         = "Gameday"
  }
}