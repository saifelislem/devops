pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "saifelislem/student-management:1.0"
        DOCKER_CREDENTIALS = "docker-hub-token"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/saifelislem/devops.git'
            }
        }

        stage('Prepare') {
            steps {
                sh 'chmod +x mvnw' // <-- cette ligne rend mvnw exécutable
            }
        }

        stage('Build Spring Boot Jar') {
            steps {
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([string(credentialsId: DOCKER_CREDENTIALS, variable: 'TOKEN')]) {
                    sh "echo $TOKEN | docker login -u saifelislem --password-stdin"
                    sh "docker push $DOCKER_IMAGE"
                }
            }
        }
    }
}
