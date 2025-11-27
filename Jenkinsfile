pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "saifelislem/student-management:1.0"
        DOCKER_CREDENTIALS = "docker-hub-token-str" // <-- ID du secret text créé dans Jenkins
        DOCKER_USER = "saifelislem" // ton nom d'utilisateur Docker Hub
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/saifelislem/devops.git'
            }
        }

        stage('Prepare') {
            steps {
                // Donne les permissions d'exécution au wrapper Maven
                sh 'chmod +x mvnw'
            }
        }

        stage('Build Spring Boot Jar') {
            steps {
                // Build le jar sans lancer les tests
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build l'image Docker
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Push Docker Image') {
            steps {
                // Utilise la credential secret text pour se connecter à Docker Hub
                withCredentials([string(credentialsId: "$DOCKER_CREDENTIALS", variable: 'TOKEN')]) {
                    sh "echo \$TOKEN | docker login -u $DOCKER_USER --password-stdin"
                    sh "docker push $DOCKER_IMAGE"
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline terminé"
        }
        success {
            echo "Pipeline réussi 👍"
        }
        failure {
            echo "Pipeline échoué ❌"
        }
    }
}
