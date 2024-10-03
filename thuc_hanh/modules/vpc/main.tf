resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MainVPC"
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}
