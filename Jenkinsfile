pipeline {
    agent any

    tools {
        maven 'M2'
        jdk 'JAVA_HOME'
    }

    environment {
        DOCKER_IMAGE = "saifelislem/student-management:1.0"
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main', url: 'https://github.com/saifelislem/devops.git'
            }
        }

        stage('Prepare') {
            steps {
                echo 'Making mvnw executable...'
                sh 'chmod +x mvnw'
            }
        }

        stage('Build JAR') {
            steps {
                echo 'Building Spring Boot project...'
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Docker Login') {
            steps {
                echo 'Logging into Docker Hub...'
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker image...'
                sh "docker push $DOCKER_IMAGE"
            }
        }
    }

    post {
        success {
            echo '✅ Build et déploiement Docker réussis !'
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
        }
        failure {
            echo '❌ Pipeline échoué.'
        }
        always {
            echo 'Pipeline finished.'
        }
    }
}
