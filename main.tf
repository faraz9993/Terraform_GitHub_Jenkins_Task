provider "aws" {
  region = "us-east-1"
}

module "aws_resources" {
	source = "./ec2"
}
