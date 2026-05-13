# Existing IAM roles
data "aws_iam_role" "ecs_execution" {
  name = "talium-ecs-execution-role-prod"
}

data "aws_iam_role" "ecs_task" {
  name = "talium-ecs-task-role-prod"
}

# Existing CloudWatch log group
data "aws_cloudwatch_log_group" "ecs" {
  name = "/ecs/talium-prod"
}

# Existing ECS cluster
data "aws_ecs_cluster" "main" {
  cluster_name = "talium-cluster-prod"
}

# Existing VPC
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["talium-vpc-prod"]
  }
}

# Existing private subnets
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

# Existing task definition
data "aws_ecs_task_definition" "talium_api" {
  task_definition = "talium-api-prod"
}
