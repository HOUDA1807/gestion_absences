pipeline {
    agent any

    environment {
        // On garde ton PATH pour docker
        PATH        = "/usr/bin:${env.PATH}"
        // On pointe vers le daemon Docker WSL exposé
        DOCKER_HOST = "tcp://172.21.68.21:2375"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test Docker & Compose') {
            steps {
                sh '''
                  echo "→ docker --version"
                  docker --version

                  echo "→ docker compose version"
                  docker compose version

                  echo "→ docker info"
                  docker info
                '''
            }
        }

        stage('Build Image (app/)') {
            steps {
                dir('app') {
                  sh '''
                    echo "→ build app image"
                    docker build \
                      -t gestion_absences_image:latest \
                      -f Dockerfile \
                      .
                  '''
                }
            }
        }

        stage('Compose Up') {
            steps {
                sh '''
                  echo "→ docker compose up -d"
                  docker compose up -d
                '''
            }
        }

        stage('Deploy with Ansible') {
            steps {
                sh '''
                  echo "→ ansible syntax-check"
                  ansible-playbook --syntax-check -i ansible/inventory.ini ansible/playbooks/deploy.yml

                  echo "→ run ansible"
                  ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml
                '''
            }
        }
    }

    post {
        always {
            sh '''
              echo "→ logs docker-compose"
              docker compose logs || true

              echo "→ docker compose down"
              docker compose down --remove-orphans || true
            '''
        }
        success {
            echo '✅ Build et déploiement réussis'
        }
        failure {
            echo '❌ Quelque chose a échoué, regarde les logs ci-dessus'
        }
    }
}
