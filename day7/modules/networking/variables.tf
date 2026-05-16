// modules/networking/variables.tf

variable "project_name" {
  description = "Name prefix for all networking resources (e.g., talium-care)"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., prod, staging)"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy networking resources into"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets (one per AZ)"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets (one per AZ)"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "enable_vpc_endpoints" {
  description = "Whether to create VPC endpoints for ECR, CloudWatch Logs, SSM"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags to apply to networking resources"
  type        = map(string)
  default     = {}
}

