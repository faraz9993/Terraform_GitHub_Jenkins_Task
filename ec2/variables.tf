variable "ami_id" {
  default = "ami-04b70fa74e45c3917"
}

data "local_file" "public_key" {
  filename = "ec2/id_rsa.pub"
}

locals {
  public_key_content = data.local_file.public_key.content
}


variable "key_name" {
  default     = "Shivi_key"
  description = "The name of the EC2 key pair"
  type        = string
}

variable "aws_region" {
  description = "The AWS region where resources will be created"
  default     = "us-east-1"  # Change this to your desired AWS region
}
