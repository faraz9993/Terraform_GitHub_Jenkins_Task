variable "ami_id" {
  default = "ami-09040d770ffe2224f"
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

