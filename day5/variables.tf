variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "talium"
}

variable "ecr_image_uri" {
  description = "361769596212.dkr.ecr.eu-west-2.amazonaws.com/talium-care-api:latest"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 5000
}

variable "task_cpu" {
  description = "Task CPU units (256, 512, 1024)"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Task memory in MB"
  type        = number
  default     = 512
}

variable "ecs_min_count" {
  description = "Minimum number of ECS tasks"
  type        = number
  default     = 1
}

variable "ecs_max_count" {
  description = "Maximum number of ECS tasks"
  type        = number
  default     = 6
}

variable "ecs_desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 2
}

variable "cpu_target_value" {
  description = "Target CPU utilisation percentage for auto scaling"
  type        = number
  default     = 60
}

variable "memory_target_value" {
  description = "Target memory utilisation percentage for auto scaling"
  type        = number
  default     = 70
}
