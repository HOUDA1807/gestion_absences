pipeline {
  agent any

  environment {
    DOCKER_BUILDKIT = '0'
    // On remonte le socket et le binaire Docker
    DOCKER_ARGS = '-u root ' +
                  '-v /var/run/docker.sock:/var/run/docker.sock ' +
                  '-v /usr/bin/docker:/usr/bin/docker'
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/HOUDA1807/gestion_absences.git', branch: 'master'
      }
    }

    stage('Install Node Dependencies') {
      steps {
        // On utilise l'image officielle node:14 pour npm
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
        // Docker CLI dans un conteneur docker:24-cli
        script {
          docker.image('docker:24.0.5-cli').inside(DOCKER_ARGS) {
            sh 'docker build -t gestion_absences_image:latest -f Dockerfile .'
          }
        }
      }
    }

    stage('Docker Compose Up') {
      steps {
        // Compose v2 dans un conteneur dédié
        script {
          docker.image('docker/compose:2.19.1').inside(DOCKER_ARGS) {
            sh 'docker-compose up -d --build'
          }
        }
      }
    }

    stage('Deploy with Ansible') {
      steps {
        // Image Alpine + Ansible
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
      echo '❌ Pipeline échouée, récupération des logs compose…'
      script {
        docker.image('docker/compose:2.19.1').inside(DOCKER_ARGS) {
          sh 'docker-compose logs --tail=50 || true'
          sh 'docker-compose down --remove-orphans || true'
        }
      }
    }
  }
}
