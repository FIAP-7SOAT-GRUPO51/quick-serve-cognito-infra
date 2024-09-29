terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.48.0"
    }
  }
}

provider "aws" {
  region = "sa-east-1"
}

module "aws_cognito_user_pool_complete" {

  source  = "lgallard/cognito-user-pool/aws"

  user_pool_name           = "QuickServeUserPool"
  deletion_protection = "INACTIVE"
 

  password_policy = {
    minimum_length    = 8
    require_lowercase = false
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
    temporary_password_validity_days = 15
  }

  schemas = [
    {
      attribute_data_type      = "Boolean"
      developer_only_attribute = false
      mutable                  = true
      name                     = "available"
      required                 = false
    },
    {
      attribute_data_type      = "Boolean"
      developer_only_attribute = true
      mutable                  = true
      name                     = "registered"
      required                 = false
    }
  ]

  string_schemas = [
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = false
      name                     = "email"
      required                 = false

      string_attribute_constraints = {
        min_length = 5
        max_length = 150
      }
    }
  ]

  recovery_mechanisms = [
     {
      name     = "verified_email"
      priority = 1
    }
  ]

  tags = {
    Owner       = "infra"
    Environment = "production"
    Terraform   = true
  }
}