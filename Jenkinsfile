pipeline {
  agent any

  environment {
    // Désactive BuildKit pour éviter les DNS internes défaillants
    DOCKER_BUILDKIT = '0'
    // Force Docker à utiliser le réseau de l'hôte
    DOCKER_NETWORK = 'host'
  }

  stages {

    stage('Checkout SCM') {
      steps {
        checkout([
          $class: 'GitSCM',
          userRemoteConfigs: [[
            url: 'https://github.com/HOUDA1807/gestion_absences.git',
            credentialsId: 'pipe'
          ]]
        ])
      }
    }

    stage('Install Node Dependencies') {
      steps {
        dir('app') {
          sh 'npm install --production'
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        sh '''
          echo "→ Building Docker image"
          DOCKER_BUILDKIT=${DOCKER_BUILDKIT} \
            docker build --network ${DOCKER_NETWORK} \
              -t gestion_absences_image:latest \
              -f Dockerfile .
        '''
      }
    }

    stage('Docker Compose Up') {
      steps {
        sh '''
          echo "→ Starting containers with Docker Compose"
          docker compose up -d
        '''
      }
    }

    stage('Deploy with Ansible') {
      steps {
        sh '''
          echo "→ Running Ansible playbook"
          ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml
        '''
      }
    }

  } // end stages

  post {
    success {
      echo '✅ Pipeline réussie !'
    }
    failure {
      echo '❌ Pipeline échouée.'
      sh 'docker compose logs'
      sh 'docker compose down --remove-orphans'
    }
  }
}
