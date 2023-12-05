resource "aws_vpc" "main" {
  for_each = var.cidr
  cidr_block = var.cidr
  tags = {
    Name = each.key
  }
}

module "subnets" {
  for_each = var.subnets
  source = "./subnets"
  subnets = each.value
  vpc_id = aws_vpc.main[each.value]
}


