/*==== The VPC ======*/
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(
    local.common_tags,
    {
        "Name"     = "${var.environment}-${var.name}"
    },
  )
}

/*==== Subnets ======*/
/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    local.common_tags,
    {
        "Name"     = "${var.environment}-${var.igw_name}"
    },
  )
}
/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [ aws_internet_gateway.ig ]
}
/* NAT */
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)
  depends_on    = [ aws_internet_gateway.ig ]
  tags = merge(
    local.common_tags,
    {
        "Name"    = "${var.environment}-${var.nat_name}"
    },
  )
}
/* Public subnet */
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr,   count.index)
  availability_zone       = element(var.availability_zones,   count.index)
  map_public_ip_on_launch = true
  tags = merge(
    local.common_tags,
    {
        "Name"     =  "${var.environment}-${var.name}-${count.index}-pub-sub"
    },
  )
}
/* Private subnet outbound */
resource "aws_subnet" "private_subnet_inbound" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnets_inbound_cidr)
  cidr_block              = var.private_subnets_inbound_cidr[count.index]
  availability_zone       = element(var.availability_zones,   count.index)
  map_public_ip_on_launch = false
  tags = merge(
    local.common_tags,
    {
        "Name"     =  "${var.environment}-${var.name}-inbound-${count.index}-prv-sub"
    },
  )
}

/* Private subnet outbound */
resource "aws_subnet" "private_subnet_outbound" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnets_outbound_cidr)
  cidr_block              = var.private_subnets_outbound_cidr[count.index]
  availability_zone       = element(var.availability_zones,   count.index)
  map_public_ip_on_launch = false
  tags = merge(
    local.common_tags,
    {
        "Name"     =  "${var.environment}-${var.name}-outbound-${count.index}-prv-sub"
    },
  )
}

/* Routing table for private subnet inbound */
resource "aws_route_table" "private_inbound" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    local.common_tags,
    {
        "Name"    = "${var.environment}-${var.name}-prv-inbound-rtb"
    },
  )
}

/* Routing table for private subnet outbound */
resource "aws_route_table" "private_outbound" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    local.common_tags,
    {
        "Name"    = "${var.environment}-${var.name}-prv-outbound-rtb"
    },
  )
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    local.common_tags,
    {
      "Name"    = "${var.environment}-${var.name}-pub-rtb"
    },
  )
}
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private_outbound.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}
/* Route table associations */
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private_inbound" {
  count          = length(var.private_subnets_inbound_cidr)
  subnet_id      = element(aws_subnet.private_subnet_inbound.*.id, count.index)
  route_table_id = aws_route_table.private_inbound.id
}
resource "aws_route_table_association" "private_outbound" {
  count          = length(var.private_subnets_outbound_cidr)
  subnet_id      = element(aws_subnet.private_subnet_outbound.*.id, count.index)
  route_table_id = aws_route_table.private_outbound.id
}
