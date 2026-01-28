pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"
    }

    stages {

        stage('Checkout') {
            steps {
                git credentialsId: 'github-creds',
                    url: 'https://github.com/RahulWakde/EKS-cluster-Terraform.git',
                    branch: 'main'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -upgrade'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-creds']
                ]) {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-creds']
                ]) {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Update kubeconfig') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-creds']
                ]) {
                    sh '''
                    CLUSTER_NAME=$(terraform output -raw cluster_name)

                    echo "Updating kubeconfig for $CLUSTER_NAME"

                    aws eks update-kubeconfig \
                      --region ${AWS_REGION} \
                      --name $CLUSTER_NAME
                    '''
                }
            }
        }

        stage('Verify Cluster') {
            steps {
                sh 'kubectl get nodes'
            }
        }

        stage('Deploy NGINX') {
            steps {
                sh 'kubectl apply -f modules/nginx/'
            }
        }
    }
}
