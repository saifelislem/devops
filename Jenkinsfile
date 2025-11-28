pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "saifelislem/student-management:1.0"
        DOCKER_USER = "saifelislem"              // Your Docker Hub username
        DOCKER_PASS = "saif.2003"     // Your Docker Hub password
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/saifelislem/devops.git'
            }
        }

        stage('Prepare') {
            steps {
                sh 'chmod +x mvnw'
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

        stage('Docker Login') {
            steps {
                // Log in to Docker Hub using environment variables
                sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
            }
        }

        stage('Push Docker Image') {
            steps {
                sh "docker push $DOCKER_IMAGE"
            }
        }
    }

    post {
        always {
            echo "Pipeline finished"
        }
        success {
            echo "valide"
        }
        failure {
            echo "failed "
        }
    }
}
