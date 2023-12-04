resource "aws_subnet" "main" {
  for_each = var.subnets
  vpc_id = var.vpc_id
  availability_zone = each.value["az"]
  cidr_block = each.value["cidr"]
  tags = {
    Name = each.key
  }
}



