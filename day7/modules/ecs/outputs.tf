############################################
# ECS Cluster & Service Outputs
############################################

output "cluster_name" {
  description = "Name of the ECS cluster."
  value       = aws_ecs_cluster.this.name
}

output "service_name" {
  description = "Name of the ECS service."
  value       = aws_ecs_service.this.name
}

output "task_definition_arn" {
  description = "ARN of the ECS task definition."
  value       = aws_ecs_task_definition.this.arn
}

############################################
# Load Balancer Outputs
############################################

output "alb_arn" {
  description = "ARN of the Application Load Balancer."
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "DNS name of the ALB (public URL)."
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ARN of the target group used by ECS service."
  value       = aws_lb_target_group.this.arn
}

output "listener_arn" {
  description = "ARN of the ALB listener."
  value       = aws_lb_listener.http.arn
}

############################################
# Auto Scaling Outputs
############################################

output "autoscaling_target_id" {
  description = "App Auto Scaling resource ID for ECS service."
  value       = aws_appautoscaling_target.ecs.resource_id
}

output "autoscaling_policy_name" {
  description = "Name of the auto scaling policy."
  value       = aws_appautoscaling_policy.request_count.name
}

