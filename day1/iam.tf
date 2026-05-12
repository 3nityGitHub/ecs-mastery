# ── ECS Task Execution Role ───────────────────────────────────────────────────
# This role allows ECS to pull images from ECR and write logs to CloudWatch

data "aws_iam_policy_document" "ecs_trust" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ecs_execution" {
  name               = "${var.project_name}-ecs-execution-role-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.ecs_trust.json

  tags = {
    Name = "${var.project_name}-ecs-execution-role-${var.environment}"
  }
}

# Attach AWS managed policy for ECS task execution
resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ── ECS Task Role ─────────────────────────────────────────────────────────────
# This role is assumed BY the running container — what your app can access

resource "aws_iam_role" "ecs_task" {
  name               = "${var.project_name}-ecs-task-role-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.ecs_trust.json

  tags = {
    Name = "${var.project_name}-ecs-task-role-${var.environment}"
  }
}

resource "aws_iam_role_policy" "ecs_task" {
  name = "${var.project_name}-ecs-task-policy-${var.environment}"
  role = aws_iam_role.ecs_task.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath",
        ]
        Resource = "arn:aws:ssm:${var.aws_region}:*:parameter/talium/*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ]
        Resource = "*"
      }
    ]
  })
}
