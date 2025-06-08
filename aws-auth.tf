# permitir que o processo de Ingress Controller faça JOIN no cluster para nós que estiverem associados a role/linuxtips-cluster-cluster-role 
resource "kubernetes_config_map" "aws-auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<YAML
-   rolearn: ${aws_iam_role.eks_cluster_role.arn}
    username: system:node:{{EC2PrivateDNSName}}
    groups:
        - system:bootstrappers
        - system:nodes
        - system:node-proxier
YAML
  }

  depends_on = [
    aws_eks_cluster.main
  ]
}