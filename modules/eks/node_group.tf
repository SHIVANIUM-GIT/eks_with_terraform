resource "aws_eks_node_group" "node-group" {
    node_group_name = "${var.name}-node-group"
    cluster_name = aws_eks_cluster.cluster.name
    node_role_arn = aws_iam_role.role_node_group.arn

    subnet_ids = var.pri_subnet_id

    scaling_config {
      desired_size = 2
      max_size = 3
      min_size = 1
    }

    instance_types = [var.instance_type]
    ami_type = var.ami_type 

    remote_access {
     ec2_ssh_key = "DevOps-Pratice"
     source_security_group_ids = [var.jump_box_sg_id]
    }

  depends_on = [
    aws_iam_role_policy_attachment.role_policy
  ]

    tags = {
      Name = "${var.name}-bottlerocket-node-group"
    }
  
}
