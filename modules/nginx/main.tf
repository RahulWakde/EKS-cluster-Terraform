provider "kubernetes" {
host = data.aws_eks_cluster.cluster.endpoint
cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
token = data.aws_eks_cluster_auth.cluster.token
}


resource "kubernetes_deployment" "nginx" {
metadata {
name = "nginx"
}


spec {
replicas = 1


selector {
match_labels = {
app = "nginx"
}
}

template {
metadata {
labels = {
app = "nginx"
}
}


spec {
container {
image = "nginx"
name = "nginx"
port {
container_port = 80
}
}
}
}
}
}
