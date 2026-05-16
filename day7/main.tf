############################################
# Terraform Backend (Remote State)
############################################

terraform {
  backend "s3" {
    bucket         = "talium-terraform-state"
    key            = "ecs/production/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "talium-terraform-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

############################################
# AWS Provider
############################################

provider "aws" {
  region = var.aws_region
}

############################################
# Networking Module
############################################

module "networking" {
  source = "./modules/networking"

  project_name        = var.project_name
  environment         = var.environment
  aws_region          = var.aws_region
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones  = var.availability_zones
  enable_vpc_endpoints = true

  tags = var.tags
}

############################################
# Security Groups Module
############################################

module "security_groups" {
  source = "./modules/security-groups"

  project_name     = var.project_name
  environment      = var.environment
  vpc_id           = module.networking.vpc_id
  alb_ingress_cidr = var.alb_ingress_cidr

  tags = var.tags
}

############################################
# Secrets Module
############################################

module "secrets" {
  source = "./modules/secrets"

  project_name = var.project_name
  environment  = var.environment

  secrets    = var.secrets
  parameters = var.parameters

  tags = var.tags
}

############################################
# ECS Module
############################################

module "ecs" {
  source = "./modules/ecs"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  private_subnet_ids = module.networking.private_subnet_ids
  public_subnet_ids  = module.networking.public_subnet_ids

  alb_sg_id = module.security_groups.alb_sg_id
  ecs_sg_id = module.security_groups.ecs_sg_id
  vpc_id = module.networking.vpc_id

  container_image = var.container_image
  container_port  = var.container_port

  cpu    = var.cpu
  memory = var.memory

  environment_variables = var.environment_variables

  secrets = {
    for key, arn in module.secrets.secret_arns :
    key => {
      name      = upper(key)
      valueFrom = arn
    }
  }

  min_capacity          = var.min_capacity
  max_capacity          = var.max_capacity
  target_request_count  = var.target_request_count
  log_retention_in_days = var.log_retention_in_days

  tags = var.tags
}

