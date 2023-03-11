resource "aws_key_pair" "this" {
  key_name   = "${var.project}-${var.env}-key"
  public_key = file("./key/terraform-aws-key.pub")

  tags = {
    "Name" = "${var.project}-${var.env}-key"
  }
}