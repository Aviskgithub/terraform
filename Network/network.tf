provider "aws" {
  region = "ap-south-1"
}


module "vpc" {
  source = "./vpc"
  vpc-cidr = var.vpc-cidr
  subnet-cidr-Public = var.subnet-cidr-Public
  subnet-cidr-Private = var.subnet-cidr-Private
}










output "vpcid" {
  value = aws_vpc.create-vpc.id
}
output "subnetid" {
  value = [for k, v in aws_subnet.create-subnet-public : v.id]
}
