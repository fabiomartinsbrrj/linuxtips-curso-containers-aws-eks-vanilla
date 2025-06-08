# Este arquivo Terraform manipula o Security Group criado automaticamente pelo cluster,
# permitindo customizações adicionais de regras de segurança conforme necessário.
resource "aws_security_group_rule" "nodeports" {
  cidr_blocks = ["0.0.0.0/0"]

  from_port         = 30000
  to_port           = 32768 # porta máxima do NodePort do Kubernetes
  description       = "Permitir trafego de entrada para NodePorts do Kubernetes"
  protocol          = "tcp"
  type              = "ingress"
  security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

resource "aws_security_group_rule" "coredns_udp" {
  cidr_blocks = ["0.0.0.0/0"]

  from_port         = 53
  to_port           = 53
  description       = "CoreDNS UDP"
  protocol          = "udp"
  type              = "ingress"
  security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

resource "aws_security_group_rule" "coredns_tcp" {
  cidr_blocks = ["0.0.0.0/0"]

  from_port         = 53
  to_port           = 53
  description       = "CoreDNS TCP"
  protocol          = "tcp"
  type              = "ingress"
  security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}