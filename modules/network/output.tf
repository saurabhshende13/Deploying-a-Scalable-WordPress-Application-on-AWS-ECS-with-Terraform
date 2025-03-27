output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets for application tier"
  value       = aws_subnet.private[*].id
}

output "db_private_subnet_ids" {
  description = "List of IDs of private subnets for application tier"
  value       = aws_subnet.db_private[*].id
}


output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables for application tier"
  value       = aws_route_table.private[*].id
}

output "db_private_route_table_ids" {
  description = "List of IDs of private route tables for application tier"
  value       = aws_route_table.db_private[*].id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "availability_zones" {
  description = "List of availability zones used"
  value       = var.availability_zones
}