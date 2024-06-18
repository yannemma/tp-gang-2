pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "emmanuel236/yoyama"
        REGISTRY_CREDENTIAL = 'dockerhublogin' // ID des credentials Docker Hub
        KUBECONFIG_CREDENTIAL = 'kubernetes' // ID des credentials Kubernetes
        dockerImage = ""
    }

    stages {
        stage('Checkout Source') {
            steps {
                git 'https://github.com/yannemma/exercice_perso_deployment1.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build DOCKER_IMAGE_NAME
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', REGISTRY_CREDENTIAL) {
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withKubeConfig([credentialsId: KUBECONFIG_CREDENTIAL]) {
                        // Appliquer le fichier deployment.yaml
                        sh 'kubectl apply -f deployment.yaml'

                        // Appliquer le fichier service.yaml
                        sh 'kubectl apply -f service.yaml'
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline terminé'
        }
        success {
            echo 'Pipeline exécuté avec succès'
        }
        failure {
            echo 'Le pipeline a échoué'
        }
    }
}
