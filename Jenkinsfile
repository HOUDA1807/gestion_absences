pipeline {
  agent any

  environment {
    DOCKER_ARGS = '-u root ' +
                  '--privileged ' +
                  '-v /var/run/docker.sock:/var/run/docker.sock ' +
                  '-v /usr/bin/docker:/usr/bin/docker'
  }

  stages {
    stage('Checkout') {
      steps {
        // Ton repo est public, pas besoin de credentials
        git url: 'https://github.com/HOUDA1807/gestion_absences.git', branch: 'master'
      }
    }

    stage('Sanity Checks') {
      steps {
        echo '→ Vérification des outils dans les containers éphémères'
        script {
          docker.image('docker:24.1.0-cli').inside(DOCKER_ARGS) {
            sh 'docker --version'
            sh 'docker-compose --version || echo "Legacy docker-compose absent"'
          }
        }
      }
    }

    stage('Install Node Dependencies') {
      steps {
        script {
          docker.image('node:14').inside(DOCKER_ARGS) {
            dir('app') {
              sh 'npm ci --production'
            }
          }
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          docker.image('docker:24.1.0-cli').inside(DOCKER_ARGS) {
            sh 'docker build -t gestion_absences_image:latest -f Dockerfile .'
          }
        }
      }
    }

    stage('Docker Compose Up') {
      steps {
        script {
          docker.image('docker/compose:2.19.1').inside(DOCKER_ARGS) {
            sh 'docker-compose up -d --build'
          }
        }
      }
    }

    stage('Deploy with Ansible') {
      steps {
        script {
          docker.image('willhallonline/ansible:alpine3').inside(DOCKER_ARGS) {
            sh 'ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml --connection=local'
          }
        }
      }
    }
  }

  post {
    success {
      echo '✅ Pipeline réussie !'
    }
    failure {
      echo '❌ Pipeline échouée, récupération des logs Docker-Compose'
      script {
        docker.image('docker/compose:2.19.1').inside(DOCKER_ARGS) {
          sh 'docker-compose logs --tail=50 || true'
          sh 'docker-compose down --remove-orphans || true'
        }
      }
    }
  }
}
