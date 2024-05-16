provider "aws" {
  region = "us-east-1"  # Replace this with your desired AWS region
}

module "aws_resources" {
	source = "./ec2"
}
