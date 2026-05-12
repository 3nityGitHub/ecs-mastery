# Reference existing IAM roles from Day 1
data "aws_iam_role" "ecs_execution" {
  name = "talium-ecs-execution-role-prod"
}

data "aws_iam_role" "ecs_task" {
  name = "talium-ecs-task-role-prod"
}

# Reference existing CloudWatch log group
data "aws_cloudwatch_log_group" "ecs" {
  name = "/ecs/talium-prod"
}

# Reference existing ECS cluster
data "aws_ecs_cluster" "main" {
  cluster_name = "talium-cluster-prod"
}

# Create a fresh VPC for ECS
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name    = "talium-vpc-prod"
    Project = "talium-tech"
    Tier    = "vpc"
  }
}

resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = ["10.0.3.0/24", "10.0.4.0/24"][count.index]
  availability_zone = ["eu-west-2a", "eu-west-2b"][count.index]

  tags = {
    Name    = "talium-private-subnet-${count.index + 1}-prod"
    Tier    = "private"
    Project = "talium-tech"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "talium-private-rt-prod"
  }
}

resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
