pipeline {
    agent any
    environment {
        // pour Docker, Compose et Ansible
        PATH = "/usr/bin:${env.PATH}"
        IMAGE_NAME = 'gestion_absences_image'
    }

    stages {
        stage('Test Docker') {
            steps { sh 'docker --version' }
        }

        stage('Test Docker Compose') {
            steps { sh 'docker compose version' }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Run with Docker Compose') {
            steps {
                sh 'docker compose down || true'
                sh 'docker compose up -d'
            }
        }

        stage('Deploy with Ansible') {
            steps {
                sh 'ansible-playbook ansible/playbooks/deploy.yml'
            }
        }
    }

    post {
        always {
            sh 'docker rm -f gestion_absences || true'
            sh 'docker compose down || true'
        }
        success {
            echo '✅ Pipeline terminée avec succès !'
        }
        failure {
            echo '❌ Échec du pipeline.'
        }
    }
}
