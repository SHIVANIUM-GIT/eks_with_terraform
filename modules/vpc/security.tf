resource "aws_security_group" "eks_cluster_sg" {
  name = "${var.name}-control-panel-sg"
  vpc_id = aws_vpc.vpc.id

  ingress{
    from_port = 443
    to_port = 443
    protocol = "tcp"
    # cidr_blocks = [var.cidr_block]
    security_groups = [aws_security_group.eks_node_group.id]
  }

  egress{
    from_port = 0
    to_port =  0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    Name = "${var.name}-control-plane-sg"
  }
}

resource "aws_security_group" "eks_node_group" {
  name =  "${var.name}-node-group-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }
  ingress {
    from_port = 1025
    to_port = 65535
    protocol = "tcp"
    security_groups = [aws_security_group.eks_cluster_sg.id]
  }

  egress{
    from_port = 0
    to_port =  0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    Name = "${var.name}-node-group-sg"
  }

}