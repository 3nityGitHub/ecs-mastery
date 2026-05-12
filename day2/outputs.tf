output "task_definition_arn" {
  description = "Task definition ARN"
  value       = aws_ecs_task_definition.talium_api.arn
}

output "task_definition_family" {
  description = "Task definition family"
  value       = aws_ecs_task_definition.talium_api.family
}

output "task_definition_revision" {
  description = "Task definition revision number"
  value       = aws_ecs_task_definition.talium_api.revision
}

output "ecs_tasks_sg_id" {
  description = "Security group ID for ECS tasks"
  value       = aws_security_group.ecs_tasks.id
}
