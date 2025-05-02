pipeline {
    agent any
    environment {
        PATH        = "/usr/bin:${env.PATH}"
        IMAGE_NAME  = 'gestion_absences_image'
        DOCKER_HOST = 'tcp://172.21.68.21:2375'
    }
    stages {
        stage('Test Docker') {
            steps { sh 'docker --version' }
        }
        stage('Test Docker Compose') {
            steps { sh 'docker compose version' }
        }
        stage('Check Docker Daemon') {
            steps {
                script {
                    if (sh(script: 'docker info', returnStatus: true) != 0) {
                        error 'Impossible de joindre le démon Docker'
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                // Construire à partir du dossier app contenant pom.xml et src
                sh "docker build -t ${IMAGE_NAME}:latest -f app/Dockerfile app"
            }
        }:latest -f Dockerfile ."
            }
        }
        stage('Run with Docker Compose') {
            steps {
                sh 'docker compose down --remove-orphans || true'
                sh 'docker compose up -d'
            }
        }
        stage('Deploy with Ansible') {
            steps { sh 'ansible-playbook ansible/playbooks/deploy.yml' }
        }
    }
    post {
        always {
            sh 'docker rm -f gestion_absences || true'
            sh 'docker compose down --remove-orphans || true'
        }
        success { echo '✅ Pipeline réussie !' }
        failure { echo '❌ Échec du pipeline.' }
    }
}

