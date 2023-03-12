resource "aws_iam_policy" "dev_policy" {
  name        = "${var.project}-${var.env}-developer"
  description = "dev"
  policy      = file("./iam_poricy/dev.policy.json")
}