variable "ami_id" {
  default = "ami-09040d770ffe2224f"
}

variable "key_name" {
  default     = "Shivi_key"
  description = "The name of the EC2 key pair"
  type        = string
}

data "local_file" "public_key" {
  filename = "/home/einfochips/.ssh/id_rsa.pub"
}

locals {
  public_key_content = data.local_file.public_key.content
}


variable "my_ip" {
  default = "14.97.73.250"
  type    = string
}
