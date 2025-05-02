pipeline {
  agent {
    dockerfile {
      filename 'jenkins-agent.Dockerfile'
      // pass docker.sock pour piloter le démon Docker de l'hôte
      args '-u root -v /var/run/docker.sock:/var/run/docker.sock'
    }
  }

  environment {
    DOCKER_BUILDKIT            = '0'
    DOCKER_NETWORK             = 'host'
    COMPOSE_DOCKER_CLI_BUILD   = '1'
  }

  stages {
    stage('Checkout') {
      steps {
        // dépôt public → pas de credentialId
        git branch: 'master', url: 'https://github.com/HOUDA1807/gestion_absences.git'
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
          echo "→ Building Docker image…"
          docker build --network ${DOCKER_NETWORK} \
            -t gestion_absences_image:latest -f Dockerfile .
        '''
      }
    }

    stage('Docker Compose Up') {
      steps {
        sh '''
          echo "→ Starting services with docker-compose…"
          docker-compose up -d --build
        '''
      }
    }

    stage('Deploy with Ansible') {
      steps {
        // On cible localhost en mode connection=local, pas de clé SSH
        sh '''
          echo "→ Deploy via Ansible…"
          ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml
        '''
      }
    }
  }

  post {
    success {
      echo '✅ Pipeline réussie !'
    }
    failure {
      echo '❌ Pipeline échouée, logs docker-compose :'
      sh 'docker-compose logs --tail=50 || true'
      sh 'docker-compose down --remove-orphans || true'
    }
  }
}
