resource "aws_eks_node_group" "main" {
  cluster_name = aws_eks_cluster.main.id

  node_group_name = format("%s-bottlerocket", aws_eks_cluster.main.id)

  node_role_arn = aws_iam_role.eks_nodes_role.arn

  instance_types = var.nodes_instance_sizes

  subnet_ids = data.aws_ssm_parameter.pod_subnets[*].value

  scaling_config {
    desired_size = lookup(var.auto_scale_options, "desired")
    max_size     = lookup(var.auto_scale_options, "max")
    min_size     = lookup(var.auto_scale_options, "min")
  }

  lifecycle {
    ignore_changes = [ # para ignorar mudanças no desired
      scaling_config[0].desired_size,
    ]
  }

  capacity_type = "SPOT"

  ami_type = "BOTTLEROCKET_x86_64"

  # ajuda a fazer especificações via node selector. Ex: So suba em nodes que tenham arch X86_64
  labels = {
    "capacity/os"   = "BOTTLEROCKET"
    "capacity/arch" = "X86_64"
    "capacity/type" = "SPOT"
  }

  tags = {
    "kubernetes.io/cluster/${var.project_name}" = "owned"
  }

  depends_on = [
    # kubernetes_config_map.aws-auth
    aws_eks_access_entry.access_entry_nodes
  ]
  # para garantir que o node group só será criado após o cluster e o aws-auth serem criados

  timeouts {
    create = "60m"
    update = "2h"
    delete = "2h"
  }

}