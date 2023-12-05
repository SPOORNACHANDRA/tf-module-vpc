resource "aws_vpc" "main" {
  cidr_block = var.cidr
}

#module "subnets" {
#  for_each = var.subnets
#  source = "./subnets"
#  subnets = each.value
#  vpc_id = aws_vpc.main.id
#}

resource "aws_subnet" "main" {
  for_each = var.subnets
  vpc_id = aws_vpc.main.id
  availability_zone_id = each.value["az"]
  cidr_block = each.value["cidr"]
}