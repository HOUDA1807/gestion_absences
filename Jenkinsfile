pipeline {
    agent any

    // 1) On surcharge le PATH pour que /usr/bin/docker soit trouvé dans le container Jenkins
    environment {
        PATH        = "/usr/bin:${env.PATH}"
        // 2) On pointe Docker vers le daemon WSL exposé sur le port 2375
        DOCKER_HOST = "tcp://172.21.68.21:2375"
    }

    stages {
        stage('Checkout') {
            steps {
                // récupère le code, dont Dockerfile et docker-compose.yml à la racine
                checkout scm
            }
        }

        stage('Test Docker') {
            steps {
                sh '''
                  echo "=== docker version ==="
                  docker --version
                  echo "=== docker info ==="
                  docker info
                '''
            }
        }

        stage('Test Docker Compose') {
            steps {
                sh 'docker compose version'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                  echo "=== build image ==="
                  docker build \
                    -t gestion_absences_image:latest \
                    -f Dockerfile \
                    .
                '''
            }
        }

        stage('Up with Docker Compose') {
            steps {
                sh '''
                  echo "=== docker compose up -d ==="
                  docker compose up -d
                '''
            }
        }

        stage('Deploy with Ansible') {
            steps {
                sh '''
                  echo "=== ansible syntax-check ==="
                  ansible-playbook --syntax-check -i ansible/inventory.ini ansible/playbooks/deploy.yml

                  echo "=== run ansible deploy ==="
                  ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml
                '''
            }
        }
    }

    post {
        always {
            // on remonte les logs et on nettoie le groupe de containers de l’app
            sh '''
              echo "=== logs docker-compose ==="
              docker compose logs || true

              echo "=== docker compose down ==="
              docker compose down --remove-orphans || true
            '''
        }
        success {
            echo '✅ Pipeline terminée avec succès'
        }
        failure {
            echo '❌ Pipeline échouée ! Voir les étapes ci-dessous.'  
        }
    }
}
