pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "saifelislem/student-management:1.0"  // ton image Docker
        DOCKER_CREDENTIALS = "docker-hub-token"            // ID du token stocké dans Jenkins Credentials
    }

    stages {
        stage('Build Docker Image') {
            steps {
                // Construire l'image Docker à partir du Dockerfile
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push Docker Image') {
            steps {
                // Authentification Docker Hub et push
                withCredentials([string(credentialsId: DOCKER_CREDENTIALS, variable: 'TOKEN')]) {
                    sh 'echo $TOKEN | docker login -u saifelislem --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }
    }
}
