pipeline {
    agent any

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
                    def userInput = input(
                        id: 'applyConfirmation',
                        message: 'Do you want to run Terraform apply?',
                        parameters: [
                            choice(choices: ['Yes', 'No'], description: 'Apply Terraform Yes or No?', name: 'applyConfirmation')
                        ]
                    )
                    if (userInput == 'Yes') {
                        withCredentials([[
                            $class: 'AmazonWebServicesCredentialsBinding',
                            credentialsId: 'Jenkins_AWS',
                        ]]) {
                            sh 'terraform apply --auto-approve'
                        }
                    } else {
                        currentBuild.result = 'ABORTED'
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
