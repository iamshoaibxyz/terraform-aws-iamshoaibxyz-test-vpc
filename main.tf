# Main VPC resource
resource "aws_vpc" "main" {
  # CIDR block and name of the VPC
  cidr_block = var.vpc_config.cidr
  
  tags = {
    "Name" = var.vpc_config.name
  }
}

# Subnet resources - creating public and private subnets
resource "aws_subnet" "main" {
  for_each = var.subnet_config
  vpc_id = aws_vpc.main.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    "Name" = each.key
    "isPublicSubnet" = each.value.public
  }
}

# Local variable for public subnets
locals {
  aws_subnet = {
    for key, config in var.subnet_config : key => config if config.public
  }
}

# Internet Gateway resource, created only if there are public subnets
resource "aws_internet_gateway" "main" {
  count = length(local.aws_subnet) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
}

# Route Table to allow internet access for public subnets
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  count = length(local.aws_subnet) > 0 ? 1 : 0

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main[0].id
  }
}

# Associate route table with public subnets
resource "aws_route_table_association" "main" {
  for_each = local.aws_subnet
  subnet_id = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.main[0].id
}
