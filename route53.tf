resource "aws_route53_zone" "this" {
  name          = var.domain
  force_destroy = true

  tags = {
    "Name" = "${var.project}-${var.env}-domain"
  }
}

resource "aws_route53_record" "this" {
  zone_id = aws_route53_zone.this.id
  name    = "dev-elb.${var.domain}"
  type    = "A"
  alias {
    name                   = aws_lb.this.dns_name
    zone_id                = aws_lb.this.zone_id
    evaluate_target_health = true
  }
}