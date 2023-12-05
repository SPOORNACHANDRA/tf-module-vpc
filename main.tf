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
  route_table_id            =each.value["id"]
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}


output "subnet" {
  value = module.subnets      # this info we need to send roboshop-pterraform-v1 main.tf
                              # # these above are all transmitting the data
}