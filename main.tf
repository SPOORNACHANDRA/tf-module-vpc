resource "aws_vpc" "main" {         #we are consuming the variables here
  cidr_block = var.cidr
}

module "subnets" {            # we have subnets in that subnets in that subnet we have multiple subnets in that subnets we have multiple values
                              #we have so that we created another module called subnets so we are sending the information
  for_each = var.subnets      # how many subnets we need so that we create a for_each so that it iterates those many times
  source = "./subnets"
  subnets = each.value        # this we created becoz we have multiple subnets in that subnets we have multiple sub-subnets  we are sending the info
  vpc_id = aws_vpc.main.id
}

#here we can create and attach to vpc is in one shot
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route" "igw" {
  for_each = lookup(lookup(module.subnets,"public",null),"route_table_ids",null)
  route_table_id            = each.value["id"]
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_eip" "ngw" {
  count = length(local.public_subnet_ids)       # we need how many subnets are there those many eip
  domain   = "vpc"
}

resource "aws_nat_gateway" "ngw" {                #how many ngw i want how many public subnets
  count = length(local.public_subnet_ids)            # here we can take either output or input we taken form output
  allocation_id = element(aws_eip.ngw.*.id,count.index)
  subnet_id     = element(local.public_subnet_ids,count.index )
}

output "subnet" {
  value = module.subnets      # this info we need to send roboshop-pterraform-v1 main.tf
                              # # these above are all transmitting the data
}

resource "aws_route" "ngw" {
  count = length(local.private_route_table_ids)
  route_table_id         = element(local.private_route_table_ids,count.index )
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id             = element(aws_nat_gateway.ngw.*.id,count.index)
}
resource "aws_vpc_peering_connection" "peering" {
  peer_vpc_id = aws_vpc.main.id
  vpc_id      = var.default_vpc_id
  auto_accept = true
}
