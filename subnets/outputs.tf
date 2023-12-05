output "subnet_ids" {        #for attaching igw to public subnets only
  value = aws_subnet.main     # first of all these guy has to send out the info to the tf-module-vpc main.tf
}


output "route_table_ids" {      #for attaching igw to public subnets only
  value = aws_route_table.main    # first of all these guy has to send out the info to the tf-module-vpc main.tf
}

# above code is written for resource "aws_route" "igw" 
# these above are all transmitting the data
