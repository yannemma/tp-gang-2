pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "emmanuel236/mon-site-web"
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
