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

        stage('Terraform Plan') {
            steps {
                // Apply Terraform changes with auto-approve
                script {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'Jenkins_AWS',
                    ]]) {
                        sh 'terraform plan'
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
                        sh 'terraform apply --auto-approve'
                    }
                }
            }
        }
        
        stage('Ask for Destroy Confirmation') {
            steps {
                script {
                    def userInput = input(
                        id: 'destroyConfirmation',
                        message: 'Do you want to run Terraform destroy?',
                        parameters: [
                            choice(choices: ['Yes', 'No'], description: 'Destroy Terraform Yes or No?', name: 'destroyConfirmation')
                        ]
                    )
                    if (userInput == 'Yes') {
                        // Proceed with Terraform destroy
                        sh 'terraform destroy --auto-approve'
                    } else {
                        // Mark build as aborted to skip the destroy stage
                        currentBuild.result = 'ABORTED'
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
