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

    stage('Build & Push Image') {
      steps {
        sh '''
          echo "→ Build de l'image Docker (inclut npm install)"
          docker build \
            --network host \
            -t gestion_absences_image:latest \
            -f Dockerfile .
        '''
        // Optionnel : push vers un registry
        // sh 'docker tag gestion_absences_image:latest monregistry/gestion_absences:latest'
        // sh 'docker push monregistry/gestion_absences:latest'
      }
    }

    stage('Up avec Docker-Compose') {
      steps {
        sh '''
          echo "→ Lancement des services via docker-compose"
          docker-compose up -d --build
        '''
      }
    }

    stage('Deploy with Ansible') {
      steps {
        sh '''
          echo "→ Déploiement via Ansible (local)"
          ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml --connection=local
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
