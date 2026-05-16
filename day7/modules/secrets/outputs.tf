############################################
# Secrets Manager outputs
############################################

output "secret_arns" {
  description = "Map of secret names to their ARNs."
  value = {
    for k, v in aws_secretsmanager_secret.this :
    k => v.arn
  }
}

############################################
# SSM Parameter Store outputs
############################################

output "parameter_names" {
  description = "Map of parameter keys to their full SSM names."
  value = {
    for k, v in aws_ssm_parameter.this :
    k => v.name
  }
}

