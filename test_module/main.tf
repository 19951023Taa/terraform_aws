resource "aws_acm_certificate" "this_test" {
  domain_name       = var.domain_name
  validation_method = var.validation_method

}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}