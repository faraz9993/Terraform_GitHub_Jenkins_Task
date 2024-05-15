pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = 'AKIAUYXBFISTO3C2NEDS'
        AWS_SECRET_ACCESS_KEY = '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'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository
                git branch: 'main', url: 'https://github.com/faraz9993/Terraform_GitHub_Jenkins_Task.git'
            }
        }
        
        stage('Terraform Init') {
            steps {
                // Initialize Terraform
                script {
                    def tfInitCmd = 'terraform init'
                    sh tfInitCmd
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                // Run Terraform plan
                script {
                    def tfPlanCmd = 'terraform plan -out=tfplan'
                    sh tfPlanCmd
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                // Apply Terraform changes with auto-approve
                script {
                    def tfApplyCmd = 'terraform apply -auto-approve tfplan'
                    sh tfApplyCmd
                }
            }
        }
    }

    post {
        always {
            // Cleanup Terraform plan file
            cleanWs()
        }
    }
}
