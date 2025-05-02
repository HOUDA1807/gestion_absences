pipeline {
  agent any

  environment {
    PATH           = "/usr/bin:${env.PATH}"
    DOCKER_BUILDKIT = '0'
  }

  stages {
    stage('Checkout') {
      steps {
        // on force HTTPS pour éviter le SSH host key
        git url: 'https://github.com/HOUDA1807/gestion_absences.git', branch: 'master'
      }
    }

    stage('Sanity Checks') {
      steps {
        echo "→ Versions dans le conteneur Jenkins :"
        sh 'docker --version'
        sh 'docker compose version'
        sh 'node --version || echo "node absent"'
        sh 'npm --version  || echo "npm absent"'
        sh 'ansible --version || echo "ansible absent"'
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
        sh '''
          echo "→ Building Docker image"
          docker build \
            --network host \
            -t gestion_absences_image:latest \
            -f Dockerfile .
        '''
      }
    }

    stage('Docker Compose Up') {
      steps {
        sh '''
          echo "→ Starting services with Docker Compose"
          docker compose up -d --build
        '''
      }
    }

    stage('Deploy with Ansible') {
      steps {
        sh '''
          echo "→ Deploy via Ansible (connection=local)"
          ansible-playbook \
            -i ansible/inventory.ini \
            ansible/playbooks/deploy.yml \
            --connection=local
        '''
      }
    }
  }

  post {
    success {
      echo '✅ Pipeline réussie !'
    }
    failure {
      echo '❌ Pipeline échouée, je récupère les logs Docker Compose…'
      sh 'docker compose logs --tail=50 || true'
      sh 'docker compose down --remove-orphans || true'
    }
  }
}
