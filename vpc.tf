# vpc.tf 
# Create VPC/subnet/Security Group/ACL

# The default provider configuration
provider "aws" {
  region = "${var.region}"
}

# end provider

# create the VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpcCIDRblock}"
  instance_tenancy     = "${var.instanceTenancy}"
  enable_dns_support   = "${var.dnsSupport}"
  enable_dns_hostnames = "${var.dnsHostNames}"

  tags = {
    Name = "VPC_${var.vpc_name}"
  }
} # end resource

# create the subnet
resource "aws_subnet" "vpc_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.subnetCIDRblock}"
  map_public_ip_on_launch = "${var.mapPublicIP}"
  availability_zone       = "${var.availabilityZone}"

  tags = {
    Name = "VPC ${var.vpc_name} subnet"
  }
} # end resource

# Create the Security Group
resource "aws_security_group" "vpc_Security_Group" {
  vpc_id      = "${aws_vpc.vpc.id}"
  name        = "VPC Security Group"
  description = "VPC Security Group"
  # allow port 22
  ingress {
    cidr_blocks = "${var.ingressCIDRblock}"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  # allow port 443
  ingress {
    cidr_blocks = "${var.ingressCIDRblock}"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }
  # allow port 8500
  ingress {
    cidr_blocks = "${var.ingressCIDRblock}"
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
  }
  # allow port 8301
  ingress {
    cidr_blocks = "${var.ingressCIDRblock}"
    from_port   = 8300
    to_port     = 8302
    protocol    = "tcp"
  }

  # allow port 8500
  ingress {
    cidr_blocks = "${var.ingressCIDRblock}"
    from_port   = 21000
    to_port     = 21255
    protocol    = "tcp"
  }

  # allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPC Security Group"
  }
} # end resource

# create VPC Network access control list
resource "aws_network_acl" "vpc_Security_ACL" {
  vpc_id     = "${aws_vpc.vpc.id}"
  subnet_ids = ["${aws_subnet.vpc_subnet.id}"]

  # allow port 22
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.destinationCIDRblock}"
    from_port  = 22
    to_port    = 22
  }
  # allow ingress ephemeral ports 
  ingress {
    protocol   = "tcp"
    rule_no    = 102
    action     = "allow"
    cidr_block = "${var.destinationCIDRblock}"
    from_port  = 443
    to_port    = 443
  }
  # allow ingress ephemeral ports 
  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = "${var.destinationCIDRblock}"
    from_port  = 1024
    to_port    = 65535
  }
  # allow egress ephemeral ports
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "VPC ACL"
  }
} # end resource

# Create the Internet Gateway
resource "aws_internet_gateway" "vpc_gw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "VPC Internet Gateway"
  }
} # end resource

# Create the Route Table

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc_gw.id}"
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      "route",
    ]
  }

  tags = {
    Name = "VPC ${var.vpc_name} Route Table"
  }
} # end resource

# route table association
resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.vpc_subnet.id}"
  route_table_id = "${aws_route_table.public.id}"
} # end resource
