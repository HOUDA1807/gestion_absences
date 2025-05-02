pipeline {
    agent any
    environment {
        PATH        = "/usr/bin:${env.PATH}"                // pour docker, docker-compose, ansible
        IMAGE_NAME  = 'gestion_absences_image'
        DOCKER_HOST = 'tcp://172.21.68.21:2375'               // démon Docker WSL
    }
    stages {
        stage('Test Docker') {
            steps {
                sh 'docker --version'
            }
        }
        stage('Test Docker Compose') {
            steps {
                sh 'docker compose version'
            }
        }
        // Vérifie la connexion au démon Docker via info plutôt que ping
        stage('Check Docker Daemon') {
            steps {
                script {
                    def status = sh(script: 'docker info', returnStatus: true)
                    if (status != 0) {
                        error "Impossible de joindre le démon Docker : code ${status}"
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }
        stage('Run with Docker Compose') {
            steps {
                sh 'docker compose down --remove-orphans || true'
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
            sh 'docker compose down --remove-orphans || true'
        }
        success {
            echo '✅ Pipeline réussie !'
        }
        failure {
            echo '❌ Échec du pipeline.'
        }
    }
}

