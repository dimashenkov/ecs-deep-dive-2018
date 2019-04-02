#----------storage/main.tf-------

provider "aws" {
  region = "eu-west-1"
  shared_credentials_file="/home/ec2-user/.aws/credentials"
}

# Create a random id 

resource "random_id" "tf_bucket_id" {
  byte_length = 2
  count = 1
}

# Create the bucket

resource "aws_s3_bucket" "tf_code" {
  count         = 1
  bucket        = "ecs-deep-dive-2018-${random_id.tf_bucket_id.*.dec[count.index]}"
  acl           = "private"
  force_destroy = true

  tags {
    Name = "tf_bucket_${count.index+1}"
  }
}
