pipeline {
    agent any

    environment {
        PATH        = "/usr/bin:${env.PATH}"
        IMAGE_NAME  = 'gestion_absences_image'
        // Laisse Docker parler au démon exposé sur 2375
        DOCKER_HOST = 'tcp://172.21.68.21:2375'
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

        stage('Check Docker Daemon') {
            steps {
                script {
                    if (sh(script: 'docker info', returnStatus: true) != 0) {
                        error("Impossible de joindre le démon Docker – vérifie DOCKER_HOST")
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                // Cible le Dockerfile à la racine et le contexte = workspace
                sh "docker build -t ${IMAGE_NAME}:latest -f Dockerfile ."
            }
        }

        stage('Run with Docker Compose') {
            steps {
                // Monte l’application avec docker-compose.yml de la racine
                sh 'docker compose down --remove-orphans || true'
                sh 'docker compose up -d'
            }
        }

        stage('Deploy with Ansible') {
            steps {
                // Inventaire et playbook dans ansible/
                sh 'ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline terminée avec succès !'
        }
        failure {
            echo '❌ Pipeline échouée !'
        }
    }
}
