resource "aws_eks_cluster" "main" {
  name = var.project_name

  version = var.k8s_version

  role_arn = aws_iam_role.eks_cluster_role.arn

  # O controlplane fica em uma VPC privada
  vpc_config {
    subnet_ids = data.aws_ssm_parameter.private_subnets[*].value
  }

  # encriptar os secrets do cluster
  encryption_config {
    provider {
      key_arn = aws_kms_key.main.arn
    }
    resources = ["secrets"]
  }

  # para fins educativo será usado os 2, mas o ideial é usar apenas API
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
    # vai dar permissões adicionais para role que criou o cluster, por tabela vai ter acesso ao cluster
    bootstrap_cluster_creator_admin_permissions = true
  }

  zonal_shift_config {
    enabled = true
    # o zonal shift é uma feature que permite que você mude o cluster de uma zona para outra, 
    # caso a zona original esteja com problemas
  }

  # isso vai dizer que para todas as operações feitas dentro do controlplane ele vai logar dentro do CloudWatch
  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  # em produção é recomendado usar CIDRs específicos, mas para fins educativos vamos deixar aberto , 
  #public_access_cidrs = []

  tags = {
    "kubernetes.io/cluster/${var.project_name}" = "shared"
  }
}