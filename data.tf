data "aws_prefix_list" "s3_prefix" {
  name = "com.amazonaws.*.s3"
}