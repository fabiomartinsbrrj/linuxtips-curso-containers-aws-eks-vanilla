variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "region" {
  description = "The region where the resources will be deployed"
  type        = string
}

variable "ssm_vpc" {
  description = "The SSM parameter name for the VPC ID"
  type        = string
}

variable "ssm_public_subnets" {
  description = "The SSM parameter name for the public subnet IDs"
  type        = list(string)
}

variable "ssm_private_subnets" {
  description = "The SSM parameter name for the private subnet IDs"
  type        = list(string)
}

variable "ssm_pod_subnets" {
  description = "The SSM parameter name for the pod subnet IDs"
  type        = list(string)

}

variable "k8s_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.31"
}

variable "auto_scale_options" {
  type = object({
    min     = number
    max     = number
    desired = number
  })
}

variable "nodes_instance_sizes" {
  description = "The instance type for the EKS worker nodes"
  type        = list(string)

}