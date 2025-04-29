pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'gestion_absences_app'
        ANSIBLE_INVENTORY = 'ansible/hosts'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'docker-compose up -d'
                sh 'docker-compose exec app pytest tests/'
            }
        }

        stage('Deploy') {
            steps {
                sh 'ansible-playbook -i $ANSIBLE_INVENTORY ansible/playbooks/deploy.yml'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
