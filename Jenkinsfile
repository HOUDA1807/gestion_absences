pipeline {
  agent any

  environment {
    PATH = "/usr/bin:${env.PATH}"
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/HOUDA1807/gestion_absences.git', branch: 'master'
      }
    }

    stage('Sanity Checks') {
      steps {
        sh '''
          echo "→ Versions dans Jenkins :"
          docker --version
          docker-compose --version
          node --version || echo "node absent"
          npm --version  || echo "npm absent"
          ansible --version || echo "ansible absent"
        '''
      }
    }

    stage('Install Node Dependencies') {
      steps {
        dir('app') {
          sh 'npm ci --production'
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t gestion_absences_image:latest -f Dockerfile .'
      }
    }

    stage('Docker Compose Up') {
      steps {
        sh 'docker-compose up -d --build'
      }
    }

    stage('Deploy with Ansible') {
      steps {
        sh 'ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml --connection=local'
      }
    }
  }

  post {
    success {
      echo '✅ Pipeline réussie !'
    }
    failure {
      echo '❌ Pipeline échouée, voici les logs docker-compose :'
      sh 'docker-compose logs --tail=50 || true'
      sh 'docker-compose down --remove-orphans || true'
    }
  }
}
