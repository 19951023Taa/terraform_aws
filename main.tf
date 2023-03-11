# ---------------------------
# Terraform configuration
# ---------------------------
terraform {
  required_version = ">=1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# ---------------------------
# Provider
# ---------------------------
provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"

  default_tags {
    tags = {
      "Env"     = var.env
      "Project" = var.project
    }
  }
}
