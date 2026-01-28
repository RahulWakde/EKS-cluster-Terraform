pipeline {
  agent any

  environment {
    AWS_DEFAULT_REGION = "ap-south-1"
    CLUSTER_NAME       = "demo-eks"
  }

  stages {

    stage('Checkout Source Code') {
      steps {
        git credentialsId: 'github-creds',
            url: 'https://github.com/RahulWakde/EKS-cluster-Terraform.git',
            branch: 'main'
      }
    }

    stage('Terraform Init') {
  steps {
    withCredentials([[
      $class: 'AmazonWebServicesCredentialsBinding',
      credentialsId: 'aws-creds'
    ]]) {
      sh '''
      rm -rf .terraform .terraform.lock.hcl
      terraform init -upgrade
      '''
    }
  }
}

    stage('Terraform Validate') {
      steps {
        sh 'terraform validate'
      }
    }

    stage('Terraform Plan') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds'
        ]]) {
          sh 'terraform plan'
        }
      }
    }

    stage('Approval Before Apply') {
      steps {
        input message: 'Approve Terraform Apply?'
      }
    }

    stage('Terraform Apply') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds'
        ]]) {
          sh 'terraform apply -auto-approve'
        }
      }
    }

    stage('Configure kubectl for EKS') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds'
        ]]) {
          sh """
          aws eks update-kubeconfig \
            --region ${AWS_DEFAULT_REGION} \
            --name ${CLUSTER_NAME}
          """
        }
      }
    }

    stage('Verify EKS & NGINX') {
      steps {
        sh '''
        kubectl get nodes
        kubectl get pods -A
        '''
      }
    }
  }

  post {
    success {
      echo 'EKS Cluster and NGINX deployed successfully.'
    }
    failure {
      echo 'Pipeline failed.'
    }
  }
}

