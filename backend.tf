terraform {
  backend "s3" {
    bucket = "w7-na-terraform"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = false
    dynamodb_table = "locktable"
  }
}
