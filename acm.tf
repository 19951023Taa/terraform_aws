resource "aws_acm_certificate" "this_tokyo" {
  domain_name       = "*.${var.domain}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_route53_zone.this
  ]

  tags = {
    "Name" = "${var.project}-${var.env}-tokyo-acm"
  }
}

resource "aws_route53_record" "this_cname" {
  for_each = {
    for k in aws_acm_certificate.this_tokyo.domain_validation_options : k.domain_name => {
      name   = k.resource_record_name
      type   = k.resource_record_type
      record = k.resource_record_value
    }
  }

  allow_overwrite = true
  zone_id         = aws_route53_zone.this.id
  name            = each.value.name
  type            = each.value.type
  ttl             = 600
  records         = [each.value.record]
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this_tokyo.arn
  validation_record_fqdns = [for k in aws_route53_record.this_cname : k.fqdn]
}

resource "aws_acm_certificate" "this_verginia" {
  provider          = aws.verginia
  domain_name       = "*.${var.domain}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_route53_zone.this
  ]

  tags = {
    "Name" = "${var.project}-${var.env}-verginia-acm"
  }
}


##### moduleを別リージョンに作成するTEST #####

# module "acm" {
#   source = "./test_module/"
#   providers = {
#     aws = aws.verginia
#   }

#   domain_name       = "bakebaketest.com"
#   validation_method = "DNS"
#  } 