# create security group

resource "aws_security_group" "sg-demo" {
    name = "webserver-sg"
    vpc_id = aws_vpc.vp1.id
    description = "Allow ssh and httpd"
    
    ingress {
        description = "allow ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "allow http"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "allow 8000"
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
 
 
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  tags= {
    env = "Dev"
  }
  depends_on = [ aws_vpc.vp1 ]
}