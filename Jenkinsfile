pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'gestion_absences_app'
        ANSIBLE_INVENTORY = 'ansible/hosts'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm  // Récupère le code du dépôt GitHub
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'  // Construire l'image Docker de l'application
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    sh 'docker-compose -f docker-compose.yml up -d'
                    sh 'docker-compose exec app pytest tests/'  // Lancer les tests dans le conteneur Docker
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh 'ansible-playbook ansible/playbooks/deploy.yml'  // Déployer avec Ansible
                }
            }
        }
    }

    post {
        always {
            cleanWs()  // Nettoyer l'espace de travail après l'exécution
        }
    }
}
