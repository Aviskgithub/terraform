resource "aws_vpc" "create-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    "Name" = "VPC-Terraform"
  }
}
resource "aws_subnet" "create-subnet-public" {
  vpc_id = aws_vpc.create-vpc.id
  for_each = var.subnet-cidr-Public
  cidr_block = each.value
  tags = {
    "Name" = "Subnet-Terraform-public"
  }
}

resource "aws_subnet" "create-subnet-private" {
  vpc_id = aws_vpc.create-vpc.id
  for_each = var.subnet-cidr-Private
  cidr_block = each.value
  tags = {
    "Name" = "Subnet-Terraform-private"
  }
}

resource "aws_route_table" "createpublicroute" {
  vpc_id = aws_vpc.create-vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.createIG.id
  }
  tags = {
    "Name" = "Public Route table"
  }
}
 resource "aws_route_table" "createprivateroute" {
   vpc_id = aws_vpc.create-vpc.id
   route {
       cidr_block = "0.0.0.0/0"
       nat_gateway_id = aws_nat_gateway.createnatgateway.id
   }
   tags = {
     "Name" = "Private Route table"
   }
 }
 
 resource "aws_internet_gateway" "createIG" {
   vpc_id = aws_vpc.create-vpc.id
   tags = {
     "Name" = "IG-Terraform"
   }
 }
 resource "aws_nat_gateway" "createnatgateway" {
   subnet_id = ""
   tags = {
     "Name" = "NatGateway-Terraform"
   }
 }
resource "aws_route_table_association" "RT-private-association" {
  route_table_id = aws_route_table.createpublicroute.id
  for_each = var.subnet-cidr-Public
  subnet_id = each.value
}
resource "aws_route_table_association" "RT-private-association" {
  route_table_id = aws_route_table.createpublicroute.id
  for_each = var.subnet-cidr-Private
  subnet_id = each.value
}