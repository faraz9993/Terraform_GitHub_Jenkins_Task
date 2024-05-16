pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository
                git branch: 'main', url: 'https://github.com/faraz9993/Terraform_GitHub_Jenkins_Task.git'
            }
        }

        stage('Navigate to Terraform directory') {
            steps {
                // Change directory to where your Terraform files are located
                dir('ec2') {
                    // Execute subsequent Terraform commands here
                }
            }
        }

        stage('Create Terraform workspace and set as current') {
            steps {
                script {
                    // Create a Terraform workspace with the Jenkins workspace name
                    sh 'terraform workspace new "Faraz" || true'
                    // Set the Terraform workspace as the current workspace
                    sh 'export TF_WORKSPACE="Faraz"'
                }
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

        stage('Terraform Plan') {
            steps {
                // Run Terraform plan
                script {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'Jenkins_AWS',
                    ]]) {
                        sh 'terraform plan -out=tfplan'
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
                        sh 'terraform apply -auto-approve tfplan'
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
