pipeline {
  agent any

  environment {
    DOCKER_BUILDKIT = '0'
    DOCKER_HOST    = 'unix:///var/run/docker.sock'
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/HOUDA1807/gestion_absences.git', branch: 'master'
      }
    }

    stage('Install Node Dependencies') {
      steps {
        script {
          docker.image('node:18').inside(
            '--user root ' +
            '--volume /var/run/docker.sock:/var/run/docker.sock ' +
            '--volume /usr/bin/docker:/usr/bin/docker '
          ) {
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
          docker.image('docker:24.0.5-cli').inside(
            '--user root ' +
            '--volume /var/run/docker.sock:/var/run/docker.sock ' +
            '--volume /usr/bin/docker:/usr/bin/docker '
          ) {
            sh 'docker build -t gestion_absences_image:latest -f Dockerfile .'
          }
        }
      }
    }

    stage('Docker Compose Up') {
      steps {
        script {
          docker.image('docker/compose:2.17.3').inside(
            '--user root ' +
            '--volume /var/run/docker.sock:/var/run/docker.sock ' +
            '--volume /usr/bin/docker:/usr/bin/docker '
          ) {
            sh 'docker-compose up -d --build'
          }
        }
      }
    }

    stage('Deploy with Ansible') {
      steps {
        script {
          docker.image('willhallonline/ansible:alpine3').inside(
            '--user root'
          ) {
            sh 'ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml'
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
      echo '❌ Pipeline échouée. Logs docker-compose :'
      script {
        docker.image('docker/compose:2.17.3').inside(
          '--user root ' +
          '--volume /var/run/docker.sock:/var/run/docker.sock ' +
          '--volume /usr/bin/docker:/usr/bin/docker '
        ) {
          sh 'docker-compose logs --tail=50 || true'
          sh 'docker-compose down --remove-orphans || true'
        }
      }
    }
  }
}
