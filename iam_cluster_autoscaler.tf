data "aws_iam_policy_document" "autoscaler" {
  # https://school.linuxtips.io/path-player?courseid=arquitetura-de-containers-na-aws&unit=6740ea70067d7d90a8086955Unit
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"] # Define a ação que permite a entidade assumir o papel usando RSA

    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
    }
  }
}

resource "aws_iam_role" "autoscaler" {
  name               = format("%s-autoscaler", var.project_name)
  assume_role_policy = data.aws_iam_policy_document.autoscaler.json
}

data "aws_iam_policy_document" "autoscaler_policy" {
  version = "2012-10-17"
  # para o autoscaler funcionar, ele precisa de permissões para acessar o EC2 e o Auto Scaling

  statement {

    effect = "Allow"
    actions = [
      "autoscaling-plans:DescribeScalingPlans",
      "autoscaling-plans:GetScalingPlanResourceForecastData",
      "autoscaling-plans:DescribeScalingPlanResources",
      "autoscaling:DescribeAutoScalingNotificationTypes",
      "autoscaling:DescribeLifecycleHookTypes",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeTerminationPolicyTypes",
      "autoscaling:DescribeScalingProcessTypes",
      "autoscaling:DescribePolicies",
      "autoscaling:DescribeTags",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeMetricCollectionTypes",
      "autoscaling:DescribeLoadBalancers",
      "autoscaling:DescribeLifecycleHooks",
      "autoscaling:DescribeAdjustmentTypes",
      "autoscaling:DescribeScalingActivities",
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAccountLimits",
      "autoscaling:DescribeScheduledActions",
      "autoscaling:DescribeLoadBalancerTargetGroups",
      "autoscaling:DescribeNotificationConfigurations",
      "autoscaling:DescribeInstanceRefreshes",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "ec2:DescribeLaunchTemplateVersions"
    ]

    resources = [
      "*"
    ]

  }
}

resource "aws_iam_policy" "autoscaler_policy" {
  name        = format("%s-autoscaler-policy", var.project_name)
  description = "Policy for EKS Cluster Autoscaler"
  policy      = data.aws_iam_policy_document.autoscaler_policy.json

}

resource "aws_iam_role_policy_attachment" "autoscaler_policy_attachment" {
  role       = aws_iam_role.autoscaler.name
  policy_arn = aws_iam_policy.autoscaler_policy.arn
}