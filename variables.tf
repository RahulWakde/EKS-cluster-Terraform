variable "region" {
description = "AWS region"
type = string
default = "ap-south-1"
}


variable "cluster_name" {
description = "EKS Cluster Name"
type = string
default = "demo-eks"
}


variable "cluster_version" {
description = "EKS Kubernetes version"
type = string
default = "1.29"
}
