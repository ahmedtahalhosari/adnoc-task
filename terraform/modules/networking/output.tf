output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private_inbound_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private_subnet_inbound.*.id

}

output "private_outbound_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private_subnet_outbound.*.id

}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public_subnet.*.id

}

output "public_tables" {
  description = "route table for public"
  value       = aws_route_table.public.id
}

output "default_security_group_id" {
  description = "default sec group for the vpc"
  value       = aws_vpc.vpc.default_security_group_id
}

output "vpc_name" {
  value = "${var.environment}-${var.name}"
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block 
}


output "private_inbound_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = aws_route_table.private_inbound.*.id
}

output "private_outbound_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = aws_route_table.private_outbound.*.id
}

output "public_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = aws_route_table.public.*.id
}

output "nat_gateway_id" {
  description = "list the id of the created NAT gateway"
  value       = aws_nat_gateway.nat.id
}
output "private_inbound_subnets_names" {
  description = "List of Names of private subnets"
  value       = aws_subnet.private_subnet_inbound.*.tags.Name

}