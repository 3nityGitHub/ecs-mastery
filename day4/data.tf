data "aws_iam_role" "ecs_execution" {
  name = "talium-ecs-execution-role-prod"
}

data "aws_iam_role" "ecs_task" {
  name = "talium-ecs-task-role-prod"
}

data "aws_cloudwatch_log_group" "ecs" {
  name = "/ecs/talium-prod"
}

data "aws_ecs_cluster" "main" {
  cluster_name = "talium-cluster-prod"
}

data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["talium-vpc-prod"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  filter {
    name   = "tag:Tier"
    values = ["private"]
  }
}

data "aws_ecs_task_definition" "talium_api" {
  task_definition = "talium-api-prod"
}
