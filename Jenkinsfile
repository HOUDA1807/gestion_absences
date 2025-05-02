 pipeline {
     agent any
     environment {
         PATH       = "/usr/bin:${env.PATH}"
         IMAGE_NAME = 'gestion_absences_image'
         DOCKER_HOST = 'tcp://host.docker.internal:2375'
         DOCKER_HOST = 'tcp://172.21.68.21:2375'
     }
     stages {
         stage('Test Docker') {
             steps { sh 'docker --version' }
         }
         stage('Ping Docker Host') {
             steps { sh 'ping -c 3 172.21.68.21' }
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
            steps { sh 'ansible-playbook ansible/playbooks/deploy.yml' }
        }
    }

    post {
        always {
            sh 'docker rm -f gestion_absences || true'
            sh 'docker compose down || true'
        }
    }
}
