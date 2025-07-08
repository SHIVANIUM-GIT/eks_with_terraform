resource "aws_eks_addon" "addons" {
  for_each           = toset([
    "vpc-cni",
    "kube-proxy", 
    "coredns"
  ])
  cluster_name       = aws_eks_cluster.cluster.name
  addon_name         = each.value
  resolve_conflicts_on_create       = "OVERWRITE"

  depends_on = [aws_eks_cluster.cluster]  
}
