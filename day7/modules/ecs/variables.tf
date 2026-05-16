############################################
# Project & Environment
############################################

variable "project_name" {
  description = "Project name used for naming ECS resources."
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., prod, staging)."
  type        = string
}

variable "aws_region" {
  description = "AWS region for ECS deployment."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the ALB target group."
  type        = string
}


############################################
# Networking Inputs
############################################

variable "private_subnet_ids" {
  description = "Private subnets where ECS tasks will run."
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Public subnets for the ALB."
  type        = list(string)
}

variable "alb_sg_id" {
  description = "Security group ID for the ALB."
  type        = string
}

variable "ecs_sg_id" {
  description = "Security group ID for ECS tasks."
  type        = string
}

############################################
# Container & Task Definition
############################################

variable "container_image" {
  description = "ECR image URI for the ECS task."
  type        = string
}

variable "container_port" {
  description = "Port the container listens on."
  type        = number
  default     = 80
}

variable "cpu" {
  description = "Fargate task CPU units."
  type        = number
  default     = 256
}

variable "memory" {
  description = "Fargate task memory (MB)."
  type        = number
  default     = 512
}

variable "environment_variables" {
  description = "Non‑secret environment variables for the container."
  type        = map(string)
  default     = {}
}

variable "secrets" {
  description = "Secrets Manager ARNs to inject into the container."
  type = map(object({
    name      = string
    valueFrom = string
  }))
  default = {}
}

############################################
# Auto Scaling
############################################

variable "min_capacity" {
  description = "Minimum number of ECS tasks."
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of ECS tasks."
  type        = number
  default     = 6
}

variable "target_request_count" {
  description = "ALB RequestCountPerTarget threshold for scaling."
  type        = number
  default     = 80
}

############################################
# Logging
############################################

variable "log_retention_in_days" {
  description = "CloudWatch log retention period."
  type        = number
  default     = 30
}

############################################
# Tagging
############################################

variable "tags" {
  description = "Common tags applied to ECS resources."
  type        = map(string)
  default     = {}
}

