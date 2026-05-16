############################################
# Project & Environment
############################################

variable "project_name" {
  description = "Project name used for naming secrets."
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., prod, staging)."
  type        = string
}

############################################
# Secrets Manager Inputs
############################################

variable "secrets" {
  description = "Map of Secrets Manager secrets to create. Key = name, value = secret string."
  type        = map(string)
  default     = {}
}

############################################
# SSM Parameter Store Inputs
############################################

variable "parameters" {
  description = "Map of SSM Parameter Store values. Key = name, value = string."
  type        = map(string)
  default     = {}
}

############################################
# Tagging
############################################

variable "tags" {
  description = "Common tags applied to all secrets and parameters."
  type        = map(string)
  default     = {}
}

