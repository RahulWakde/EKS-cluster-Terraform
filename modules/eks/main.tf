module "eks" {
source = "terraform-aws-modules/eks/aws"
version = "20.8.4"


cluster_name = "eks"
cluster_version = "1.29"


vpc_id = var.vpc_id
subnet_ids = var.subnet_ids


eks_managed_node_groups = {
default = {
desired_size = 2
min_size = 1
max_size = 3
instance_types = ["t3.medium"]
}
}
}
