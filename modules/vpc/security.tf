resource "aws_security_group" "node-group-sg" {
  name = "${var.name}-node-group-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   =  443 
    to_port     =  443
    protocol    = "tcp"
    cidr_blocks =[ var.cidr_block]
  }

  ingress {
    from_port   =  0
    to_port     =  65535
    protocol    = "tcp"
    self = true
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-node-group-sg"
  }
  
}

resource "aws_security_group" "jump-box-sg" {
  vpc_id = aws_vpc.vpc.id
  name = "${var.name}-jump-box-sg"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  [var.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-jump-box-sg"
  }

}