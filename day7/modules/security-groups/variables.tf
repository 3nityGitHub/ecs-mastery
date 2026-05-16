############################################
# Required Inputs
############################################

variable "project_name" {
  description = "Project name used for naming and tagging."
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., prod, staging)."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where security groups will be created."
  type        = string
}

############################################
# Ingress Controls
############################################

variable "alb_ingress_cidr" {
  description = "CIDR allowed to access the ALB (0.0.0.0/0 for public)."
  type        = string
  default     = "0.0.0.0/0"
}

############################################
# Tagging
############################################

variable "tags" {
  description = "Common tags applied to all security groups."
  type        = map(string)
  default     = {}
}

