resource "aws_security_group" "control-panel-sg" {
  name = "${var.name}-sg"
  vpc_id = aws_vpc.vpc.id

  ingress{
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    from_port = 10250
    to_port = 10250
    protocol = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  egress{
    from_port = 0
    to_port =  0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    Name = "${var.name}-control-plane-sg"
  }
}

