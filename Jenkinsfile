pipeline {
    agent any

    environment {
        // Pour être sûr que docker et docker compose sont trouvés
        PATH = "/usr/bin:${env.PATH}"
        IMAGE_NAME = 'gestion_absences_image'
    }

    stages {
        stage('Test Docker') {
            steps {
                script {
                    sh 'docker --version'
                }
            }
        }

        stage('Test Docker Compose') {
            steps {
                script {
                    sh 'docker compose version'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Run with Docker Compose') {
            steps {
                script {
                    // Arrêt/cleanup éventuel
                    sh 'docker compose down || true'
                    // Lancement des services
                    sh 'docker compose up -d'
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                script {
                    // Adapté à ton inventaire et playbook
                    sh 'ansible-playbook -i ansible/inventory/production ansible/deploy.yml'
                }
            }
        }
    }

    post {
        always {
            script {
                // Nettoyage final
                sh 'docker rm -f gestion_absences || true'
                sh 'docker compose down || true'
            }
        }
        success {
            echo '✅ Pipeline terminée avec succès !'
        }
        failure {
            echo '❌ Échec du pipeline.'
        }
    }
}
