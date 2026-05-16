############################################
# Networking Outputs
############################################

output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs for ALB."
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks."
  value       = module.networking.private_subnet_ids
}

############################################
# Security Groups Outputs
############################################

output "alb_sg_id" {
  description = "Security group ID for the ALB."
  value       = module.security_groups.alb_sg_id
}

output "ecs_sg_id" {
  description = "Security group ID for ECS tasks."
  value       = module.security_groups.ecs_sg_id
}

output "db_sg_id" {
  description = "Security group ID for the database."
  value       = module.security_groups.db_sg_id
}

############################################
# Secrets Outputs
############################################

output "secret_arns" {
  description = "Map of secret names to their ARNs."
  value       = module.secrets.secret_arns
}

output "parameter_names" {
  description = "Map of SSM parameter keys to their full names."
  value       = module.secrets.parameter_names
}

############################################
# ECS Outputs
############################################

output "cluster_name" {
  description = "Name of the ECS cluster."
  value       = module.ecs.cluster_name
}

output "service_name" {
  description = "Name of the ECS service."
  value       = module.ecs.service_name
}

output "task_definition_arn" {
  description = "ARN of the ECS task definition."
  value       = module.ecs.task_definition_arn
}

############################################
# Load Balancer Outputs
############################################

output "alb_dns_name" {
  description = "Public DNS name of the ALB."
  value       = module.ecs.alb_dns_name
}

output "alb_arn" {
  description = "ARN of the ALB."
  value       = module.ecs.alb_arn
}

output "target_group_arn" {
  description = "ARN of the ALB target group."
  value       = module.ecs.target_group_arn
}

output "listener_arn" {
  description = "ARN of the ALB listener."
  value       = module.ecs.listener_arn
}

############################################
# Auto Scaling Outputs
############################################

output "autoscaling_target_id" {
  description = "App Auto Scaling resource ID for ECS service."
  value       = module.ecs.autoscaling_target_id
}

output "autoscaling_policy_name" {
  description = "Name of the auto scaling policy."
  value       = module.ecs.autoscaling_policy_name
}

