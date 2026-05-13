resource "aws_ecs_service" "talium_api" {
  name            = "${var.project_name}-api-service-${var.environment}"
  cluster         = data.aws_ecs_cluster.main.arn
  task_definition = data.aws_ecs_task_definition.talium_api.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.private.ids
    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.talium_api.arn
    container_name   = "talium-api"
    container_port   = var.container_port
  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  depends_on = [aws_lb_listener.http]

  tags = {
    Name = "${var.project_name}-api-service-${var.environment}"
  }
}
