resource "aws_eks_cluster" "cluster" {
  name = "${var.name}-cluster"
  role_arn = aws_iam_role.eks_role.arn

  version = "1.33"

  vpc_config {
    subnet_ids = var.pri_subnet_id
    security_group_ids = [var.sg_control_id]

    endpoint_private_access = true
    endpoint_public_access  = false
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator"]
  depends_on = [ aws_iam_role_policy_attachment.eks_cluster_policy ]
}
