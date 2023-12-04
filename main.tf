resource "aws_vpc" "main" {
  for_each = var.vpc
  cidr_block = var.cidr
  tags = {
    Name = lookup(var.vpc,each.key )
  }
}

module "subnets" {
  for_each = var.subnets
  source = "./subnets"
  subnets = each.value
  vpc_id = aws_vpc.main.id
}