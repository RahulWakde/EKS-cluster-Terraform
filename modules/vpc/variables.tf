variable "vpc_name" {
description = "VPC name"
type = string
default = "eks-vpc"
}


variable "vpc_cidr" {
description = "VPC CIDR block"
type = string
default = "10.0.0.0/16"
}


variable "azs" {
description = "Availability Zones"
type = list(string)
default = ["ap-south-1a", "ap-south-1b"]
}
variable "private_subnets" {
description = "Private subnet CIDRs"
type = list(string)
default = ["10.0.1.0/24", "10.0.2.0/24"]
}


variable "public_subnets" {
description = "Public subnet CIDRs"
type = list(string)
default = ["10.0.101.0/24", "10.0.102.0/24"]
}


