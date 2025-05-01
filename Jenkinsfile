pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "gestion_absences"
        DOCKER_TAG = "latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git credentialsId: 'pipe', url: 'https://github.com/HOUDA1807/gestion_absences.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Run with Docker Compose') {
            steps {
                sh 'docker-compose down || true'
                sh 'docker-compose up -d'
            }
        }

        stage('Deploy with Ansible') {
            when {
                expression { fileExists('ansible/playbook.yml') }
            }
            steps {
                sh 'ansible-playbook ansible/playbook.yml'
            }
        }
    }

    post {
        success {
            echo '✅ Déploiement réussi.'
        }
        failure {
            echo '❌ Échec du pipeline.'
        }
    }
}
