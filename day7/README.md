# Talium Care Management — ECS Production Stack

Complete AWS ECS Fargate infrastructure for the Talium Care Management platform.

## What This Deploys

- **VPC** with public/private subnets across 2 AZs
- **NAT Gateways** for private subnet outbound access
- **VPC Endpoints** for ECR and CloudWatch (no internet needed for image pulls/logs)
- **Application Load Balancer** in public subnets with health checks
- **ECS Fargate** service in private subnets with 2 tasks
- **Auto Scaling** (min 1, max 6) based on CPU
- **Secrets Manager** for database credentials
- **SSM Parameter Store** for app configuration
- **CloudWatch** logs and alarms
- **ECR** repository with image scanning

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0
- Docker (for local builds)
- GitHub repository with Actions enabled (for CI/CD)

## Quick Start

### 1. Prepare Terraform Backend

```bash
aws s3 mb s3://talium-terraform-state-prod --region eu-west-2
aws dynamodb create-table \
  --table-name talium-terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region eu-west-2
```

### 2. Deploy Infrastructure

```bash
cd day7
terraform init
terraform plan
terraform apply
```

### 3. Build and Push Docker Image

```bash
aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin $(terraform output -raw ecr_repository_url)

docker build -t talium-api .
docker tag talium-api:latest $(terraform output -raw ecr_repository_url):latest
docker push $(terraform output -raw ecr_repository_url):latest
```

### 4. Verify Deployment

```bash
# Check ALB is responding
curl http://$(terraform output -raw alb_dns_name)/health

# Check ECS tasks are running
aws ecs describe-services \
  --cluster $(terraform output -raw ecs_cluster_name) \
  --services $(terraform output -raw ecs_service_name) \
  --region eu-west-2

# Check target group health
aws elbv2 describe-target-health \
  --target-group-arn $(terraform output -raw target_group_arn) \
  --region eu-west-2
```

### 5. View Logs

```bash
aws logs tail /ecs/talium-api-prod --follow --region eu-west-2
```

## Destroy Everything

```bash
terraform destroy
```

**Warning:** This deletes all resources including ECR images. Use with caution in production.

## Architecture

```
Internet → ALB (Public Subnets) → ECS Fargate (Private Subnets)
                ↓                        ↓
           Security Group            Security Group
           (Port 80/443)            (Port 5000 from ALB only)
                ↓                        ↓
           Health Checks            VPC Endpoints → ECR/CloudWatch
```

## Security Notes

- ECS tasks run in private subnets with no public IP
- Only the ALB is exposed to the internet
- Database credentials are stored in Secrets Manager, never in Git
- Security groups use group-to-group references, not CIDR blocks
- ECR images are scanned on push
```

