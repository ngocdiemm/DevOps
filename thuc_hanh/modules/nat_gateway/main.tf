variable "public_subnet" {}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet
  tags = {
    Name = "NATGateway"
  }
}

output "nat_gw_id" {
  value = aws_nat_gateway.nat_gw.id
}
