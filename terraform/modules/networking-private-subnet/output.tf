output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private_subnet.*.id
}


output "private_tables" {
  description = "route table for private"
  value       = aws_route_table.private.id
}

output "vpc_name" {
  value = "${var.environment}-${var.name}"
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block 
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = aws_route_table.private.*.id
}

output "private_subnets_names" {
  description = "List of Names of private subnets"
  value       = aws_subnet.private_subnet.*.tags.Name

}
