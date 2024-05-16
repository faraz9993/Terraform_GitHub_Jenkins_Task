resource "aws_instance" "first_resource" {
  ami             = var.ami_id
  instance_type   = "t2.micro"
  key_name        = var.key_name
  subnet_id       = "subnet-0380079a7f48b2780"  # Replace with your subnet ID
  availability_zone = "${var.aws_region}a"  # Example: us-west-2a
}





resource "aws_key_pair" "second_resource" {
  key_name   = var.key_name
  public_key = local.public_key_content
}

resource "aws_security_group" "third_resource" {
  name        = "my-security-group"
  description = "Security group allowing HTTP, HTTPS, and SSH access from my IP"


  ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from all IP addresses
}

ingress {
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from all IP addresses
}

ingress {
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS from all IP addresses
}

egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic to all IP addresses
}
}
