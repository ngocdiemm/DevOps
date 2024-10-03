variable "public_sg_id" {}
variable "private_sg_id" {}
variable "public_subnet" {}
variable "private_subnet" {}
variable "key_name" {}

resource "aws_instance" "public_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Thay bằng AMI bạn chọn
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet
  key_name      = var.key_name

  tags = {
    Name = "PublicInstance"
  }

  security_groups = [var.public_sg_id]
}

resource "aws_instance" "private_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Thay bằng AMI bạn chọn
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet
  key_name      = var.key_name

  tags = {
    Name = "PrivateInstance"
  }

  security_groups = [var.private_sg_id]
}
