output "alb_dns_name" {
  description = "ALB DNS name — your app URL"
  value       = aws_lb.main.dns_name
}

output "alb_arn" {
  description = "ALB ARN"
  value       = aws_lb.main.arn
}

output "target_group_arn" {
  description = "Target group ARN"
  value       = aws_lb_target_group.talium_api.arn
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.talium_api.name
}

output "autoscaling_min" {
  description = "Minimum task count"
  value       = aws_appautoscaling_target.ecs_service.min_capacity
}

output "autoscaling_max" {
  description = "Maximum task count"
  value       = aws_appautoscaling_target.ecs_service.max_capacity
}

output "cpu_alarm_name" {
  description = "CPU high alarm name"
  value       = aws_cloudwatch_metric_alarm.cpu_high.alarm_name
}
