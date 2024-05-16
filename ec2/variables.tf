variable "ami_id" {
  default = "ami-09040d770ffe2224f"
}

variable "key_name" {
  default     = "Shivi_key"
  description = "The name of the EC2 key pair"
  type        = string
}

