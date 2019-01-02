########################################
# AWS VPC config:                      #
# 2x Public Subnets (eu-west2a/2b)     #
# 2x Private Subnets (eu-west2a/2b)    #
# 1x IGW                               #
# 1x NAT                               #
#                                      #
#    Author: Phil H  29/12/18 v0.1     #
########################################

# Create main AWS VPC
resource "aws_vpc" "main" {
  cidr_block       = "${var.VPC_CIDR_BLOCK}"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.PROJECT_NAME}-vpc"
  }
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

# Create subnets

# Public subnet(s)
# Loop through public CIDR subnets

resource "aws_subnet" "public_subnet" {

  count = "${length(var.VPC_PUBLIC_SUBNET)}"
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${element(var.VPC_PUBLIC_SUBNET, count.index)}"
  availability_zone = "${element(var.VPC_AV_ZONES, count.index)}"

  tags = {

    Name = "${var.PROJECT_NAME}_public_${count.index}"
  }
}

output "all_public_subnet_ids" {
  value = "${aws_subnet.public_subnet.*.id}"
}

# Private subnet(s)
# Loop through private CIDR subnets
resource "aws_subnet" "private_subnet" {

  count = "${length(var.VPC_PRIVATE_SUBNET)}"
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${element(var.VPC_PRIVATE_SUBNET, count.index)}"
  availability_zone = "${element(var.VPC_AV_ZONES, count.index)}"

  tags = {

    Name = "${var.PROJECT_NAME}_private_${count.index}"
  }
}

output "all_private_subnet_ids" {
  value = "${aws_subnet.private_subnet.*.id}"
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {

  vpc_id  = "${aws_vpc.main.id}"

    tags {
      Name  = "Internet_Gateway.${var.PROJECT_NAME}"
    }
}

# Elastic IP for NAT
resource "aws_eip" "eip" {

  vpc = "true"
  depends_on = ["aws_internet_gateway.igw"]

  tags {
    Name = "${var.PROJECT_NAME}-eip"
  }
}

# NAT gateway for private subnet 1
resource "aws_nat_gateway" "ngw" {

  allocation_id = "${aws_eip.eip.id}"
  subnet_id     = "${aws_subnet.private_subnet.*.id[0]}"
  depends_on = ["aws_internet_gateway.igw"]

  tags {
    Name = "${var.PROJECT_NAME}-NAT-gateway"
  }
}

# Route table for public subnet
resource "aws_route_table" "public" {

  vpc_id     = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${var.PROJECT_NAME}-route-public"
  }
}

# Route table for private subnet
resource "aws_route_table" "private" {

  vpc_id     = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.ngw.id}"
  }
  tags {
    Name = "${var.PROJECT_NAME}-route-private"
  }
}

# Route associations - Public
resource "aws_route_table_association" "public_subnet" {
  count = "${length(var.VPC_PUBLIC_SUBNET)}"
  subnet_id      = "${aws_subnet.public_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}

# Route associations - Private
resource "aws_route_table_association" "private_subnet" {
  count = "${length(var.VPC_PRIVATE_SUBNET)}"
  subnet_id      = "${aws_subnet.private_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.id}"
}


# Create Subnet group for RDS DB
resource "aws_db_subnet_group" "RDS_subnet" {

  #count = "${length(var.VPC_PRIVATE_SUBNET)}"
  name  = "db_subnet_group"
  subnet_ids = ["${aws_subnet.private_subnet.*.id}"]

  tags {
        Name = "${var.PROJECT_NAME}-rds-subnet"
    }
}
