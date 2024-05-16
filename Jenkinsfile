pipeline {
    agent any

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
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'Jenkins_AWS',
                    ]]) {
                        sh 'terraform init'
                    }
                }
            }
        }


        stage('Terraform Apply') {
            steps {
                // Apply Terraform changes with auto-approve
                script {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'Jenkins_AWS',
                    ]]) {
                        sh 'terraform apply -auto-approve'
                    }
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
