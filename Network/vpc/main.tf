resource "aws_vpc" "create-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    "Name" = "VPC-Terraform"
  }
}

resource "aws_subnet" "create-subnet-public" {
  vpc_id     = aws_vpc.create-vpc.id
  for_each   = var.subnet-cidr-Public
  cidr_block = each.value
  tags = {
    "Name" = "Subnet-Terraform-public"
  }
}

resource "aws_subnet" "create-subnet-private" {
  vpc_id     = aws_vpc.create-vpc.id
  for_each   = var.subnet-cidr-Private
  cidr_block = each.value
  tags = {
    "Name" = "Subnet-Terraform-private"
  }
}