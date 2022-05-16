resource "aws_internet_gateway" "createIG" {
  vpc_id = aws_vpc.create-vpc.id
  tags = {
    "Name" = "IG-Terraform"
  }
}
resource "aws_eip" "createEIP" {
  tags = {
    "Name" = "ElasticIP-Terraform"
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
locals  {
subnetID = aws_subnet.create-subnet-public
}
resource "aws_route_table_association" "RT-public-association" {
  route_table_id = aws_route_table.createpublicroute.id
  for_each       = toset([for k, v in local.subnetID : v.id])
  subnet_id      = each.value
}
