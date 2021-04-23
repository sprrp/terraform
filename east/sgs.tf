data "aws_vpc" "default" {}

resource "aws_security_group" "default" {
  name        = "surendra-west"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${data.aws_vpc.default.id}"

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
