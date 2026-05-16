############################################
# Project & Environment
############################################

variable "project_name" {
  description = "Project name used for naming all resources."
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., prod, staging)."
  type        = string
}

variable "aws_region" {
  description = "AWS region for deployment."
  type        = string
}

############################################
# Networking Inputs
############################################

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs."
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones."
  type        = list(string)
}

############################################
# Security Inputs
############################################

variable "alb_ingress_cidr" {
  description = "CIDR allowed to access the ALB."
  type        = string
}

############################################
# ECS Inputs
############################################

variable "container_image" {
  description = "ECR image URI for the ECS service."
  type        = string
}

variable "container_port" {
  description = "Port the container listens on."
  type        = number
}

variable "cpu" {
  description = "Fargate task CPU units."
  type        = number
}

variable "memory" {
  description = "Fargate task memory (MB)."
  type        = number
}

variable "environment_variables" {
  description = "Non-secret environment variables for the ECS container."
  type        = map(string)
  default     = {}
}

############################################
# Secrets & Parameters
############################################

variable "secrets" {
  description = "Map of Secrets Manager secrets to create."
  type        = map(string)
  default     = {}
}

variable "parameters" {
  description = "Map of SSM Parameter Store values."
  type        = map(string)
  default     = {}
}

############################################
# Auto Scaling
############################################

variable "min_capacity" {
  description = "Minimum number of ECS tasks."
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of ECS tasks."
  type        = number
}

variable "target_request_count" {
  description = "ALB RequestCountPerTarget threshold for scaling."
  type        = number
}

############################################
# Logging
############################################

variable "log_retention_in_days" {
  description = "CloudWatch log retention period."
  type        = number
}

############################################
# Tagging
############################################

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}

