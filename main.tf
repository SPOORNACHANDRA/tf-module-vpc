resource "aws_vpc" "main" {
  cidr_block = var.cidr
  tags = {
    Name = "Default subnet for us-west-2a"
  }
}