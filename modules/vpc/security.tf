# EKS Control Plane SG
resource "aws_security_group" "eks_cluster_sg" {
  name        = "${var.name}-control-plane-sg"
  description = "Security group for EKS control plane"
  vpc_id      = aws_vpc.vpc.id

  # Allow all outbound traffic (for control plane to nodes, S3, etc.)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-control-plane-sg"
  }
}

# EKS Worker Node SG
resource "aws_security_group" "eks_node_group" {
  name        = "${var.name}-node-group-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = aws_vpc.vpc.id

  # Allow SSH access to worker nodes (consider restricting to admin IP/bastion)
  ingress {
    description = "Allow SSH from public subnets"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.pub_subnet
  }

  # Allow all traffic within the node group (node-to-node)
  ingress {
    description = "Allow all traffic within the node group"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  # Allow all outbound traffic (for internet, ECR, S3, etc.)
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

# SG Rules: Node → Control Plane (API Server)
resource "aws_security_group_rule" "node_to_controlplane" {
  description              = "Allow nodes to access Kubernetes API on control plane"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster_sg.id
  source_security_group_id = aws_security_group.eks_node_group.id
}

# SG Rules: Control Plane → Node (Kubelet, Pods)
# Optional: Control Plane → Node on port 443 (some metrics)
resource "aws_security_group_rule" "controlplane_to_node_443" {
  description              = "Allow control plane to access kubelet metrics on nodes"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_node_group.id
  source_security_group_id = aws_security_group.eks_cluster_sg.id
}

# Required: Control Plane → Node (for pod and container runtime)
resource "aws_security_group_rule" "controlplane_to_node_pods" {
  description              = "Allow control plane to communicate with pods on nodes"
  type                     = "ingress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_node_group.id
  source_security_group_id = aws_security_group.eks_cluster_sg.id
}
