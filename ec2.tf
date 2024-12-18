# create ec2 instance
resource "aws_instance" "server1" {
  ami           = "ami-0195204d5dce06d99"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.sg-demo.id]
  key_name      = aws_key_pair.aws_key.key_name
  user_data     = file("server.sh")
  tags ={
    Name = "utc-app-inst"
  }
}