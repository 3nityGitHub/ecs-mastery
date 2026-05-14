# ── GitHub OIDC Provider ──────────────────────────────────────────────────────
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = [
  "6938fd4d98bab03faadb97b34396831e3780aea1",
  "1c58a3a8518e8759bf075b76b750d4f2df264fcd"
]

  tags = {
    Name = "github-actions-oidc"
  }
}

# ── GitHub Actions IAM Role ───────────────────────────────────────────────────
data "aws_iam_policy_document" "github_oidc_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:3nityGitHub/ecs-mastery:*"]
    }
  }
}

resource "aws_iam_role" "github_actions" {
  name               = "github-actions-ecs-role"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_trust.json

  tags = {
    Name = "github-actions-ecs-role"
  }
}

# ── GitHub Actions IAM Policy ─────────────────────────────────────────────────
resource "aws_iam_role_policy" "github_actions" {
  name = "github-actions-ecs-policy"
  role = aws_iam_role.github_actions.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecs:UpdateService",
          "ecs:DescribeServices",
          "ecs:RegisterTaskDefinition",
          "ecs:DescribeTaskDefinition",
          "ecs:ListTaskDefinitions",
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "iam:PassRole",
        ]
        Resource = [
          "arn:aws:iam::*:role/talium-ecs-execution-role-prod",
          "arn:aws:iam::*:role/talium-ecs-task-role-prod",
        ]
      }
    ]
  })
}
