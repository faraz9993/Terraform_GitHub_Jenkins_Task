pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = secret.AWS_ACCESS_KEY_ID
        AWS_SECRET_ACCESS_KEY = secret.AWS_SECRET_ACCESS_KEY
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/faraz9993/Terraform_GitHub_Jenkins_Task.git'
            }
        }
        
        stage('Terraform Init') {
            steps {
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
                        withCredentials([[
                            $class: 'AmazonWebServicesCredentialsBinding',
                            credentialsId: 'Jenkins_AWS',
                        ]]) {
                            sh 'terraform destroy --auto-approve'
                        }
                    } else {
                        currentBuild.result = 'ABORTED'
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
