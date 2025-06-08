resource "aws_kms_key" "main" {
  description = "KMS key for ${var.project_name} EKS cluster"

  tags = {
    Name = "${var.project_name}-eks-kms-key"
  }

}

resource "aws_kms_alias" "main" {
  name          = "alias/${var.project_name}-eks-kms-key"
  target_key_id = aws_kms_key.main.key_id
}