resource "aws_instance" "app" {
  ami = data.aws_ami.app_ami.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public_subnet_1a.id
  associate_public_ip_address = true

  vpc_security_group_ids = [ 
    aws_security_group.app_ec2_sg.id,
    aws_security_group.opp_sg.id
   ]

   key_name = aws_key_pair.this.key_name

  tags = {
    "Name" = "${var.project}-${var.env}-app-ec2"
  }
}