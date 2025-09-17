module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.3.1"
  name    = local.cluster_name
  #name    = local.cluster_name
  #cluster_version = var.kubernetes_version
  kubernetes_version = "1.33"
  subnet_ids         = module.vpc.private_subnets

  enable_irsa = true

  tags = {
    cluster = "demo"
  }

  vpc_id = module.vpc.vpc_id

  # eks_managed_node_group_defaults = {
  #   ami_type               = "AL2_x86_64"
  #   instance_types         = ["t3.medium"]
  #   vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  # }

  eks_managed_node_groups = {

    node_group = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      #ami_type       = "AL2_x86_64"
      #ami_id        = "ami-0e796ccc93168da3a"
      instance_types = ["t3.micro"]
      vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]

      min_size     = 2
      max_size     = 6
      desired_size = 2

    }
  }
}

