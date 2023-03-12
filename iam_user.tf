resource "aws_iam_user" "this" {
  name          = "${var.project}-${var.env}-developer-user"
  force_destroy = true
}

resource "aws_iam_user_group_membership" "this" {
  user = aws_iam_user.this.name
  groups = [
    aws_iam_group.this.name
  ]
}

resource "aws_iam_user_login_profile" "this" {
  user                    = aws_iam_user.this.name
  pgp_key                 = filebase64("./cert/master.pub.gpg")
  password_length         = 20
  password_reset_required = true
}

output "user_pass" {
  value = aws_iam_user_login_profile.this.encrypted_password
}