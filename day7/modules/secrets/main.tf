############################################
# Secrets Manager secrets
############################################

resource "aws_secretsmanager_secret" "this" {
  for_each = var.secrets

  name = "${var.project_name}/${var.environment}/${each.key}"

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${var.environment}-secret-${each.key}"
    Environment = var.environment
  })
}

resource "aws_secretsmanager_secret_version" "this" {
  for_each = var.secrets

  secret_id     = aws_secretsmanager_secret.this[each.key].id
  secret_string = each.value
}

############################################
# SSM Parameter Store parameters
############################################

resource "aws_ssm_parameter" "this" {
  for_each = var.parameters

  name  = "/${var.project_name}/${var.environment}/${each.key}"
  type  = "String"
  value = each.value

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${var.environment}-param-${each.key}"
    Environment = var.environment
  })
}

