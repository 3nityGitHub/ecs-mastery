############################################
# VPC Outputs
############################################

output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC."
  value       = aws_vpc.this.cidr_block
}

############################################
# Subnet Outputs
############################################

output "public_subnet_ids" {
  description = "List of public subnet IDs."
  value       = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs."
  value       = [for s in aws_subnet.private : s.id]
}

############################################
# Route Table Outputs
############################################

output "public_route_table_id" {
  description = "Route table ID for public subnets."
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "Route table IDs for private subnets."
  value       = { for k, rt in aws_route_table.private : k => rt.id }
}

############################################
# NAT Gateway Outputs
############################################

output "nat_gateway_ids" {
  description = "NAT Gateway IDs for each public subnet."
  value       = { for k, nat in aws_nat_gateway.nat : k => nat.id }
}

############################################
# VPC Endpoint Outputs
############################################

output "ecr_api_endpoint_id" {
  description = "VPC endpoint ID for ECR API."
  value       = try(aws_vpc_endpoint.ecr_api[0].id, null)
}

output "ecr_dkr_endpoint_id" {
  description = "VPC endpoint ID for ECR Docker."
  value       = try(aws_vpc_endpoint.ecr_dkr[0].id, null)
}

output "logs_endpoint_id" {
  description = "VPC endpoint ID for CloudWatch Logs."
  value       = try(aws_vpc_endpoint.logs[0].id, null)
}

