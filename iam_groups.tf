resource "aws_iam_group" "this" {
  name = "${var.project}-${var.env}-developer-group"
}

resource "aws_iam_group_policy_attachment" "this" {
  group      = aws_iam_group.this.name
  policy_arn = aws_iam_policy.dev_policy.arn
}