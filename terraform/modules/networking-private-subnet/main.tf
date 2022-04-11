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

/* Private subnet */
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones,   count.index)
  map_public_ip_on_launch = false
  tags = merge(
    local.common_tags,
    {
        "Name"     = "${var.environment}-${var.name}-${count.index}-prv-sub"
    },
  )
}
/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    local.common_tags,
    {
        "Name"   = "${var.environment}-${var.name}-prv-rtb"
    },
  )
}

/* Route table associations */

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private.id
}