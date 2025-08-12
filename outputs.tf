// filepath: nodes.tf
output "asg_names" {
  value = data.aws_autoscaling_groups.eks.names
}