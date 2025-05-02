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

    stage('Build Docker Image') {
      steps {
        echo "→ Build de l'image Docker"
        sh '''
          newgrp docker -c "docker build --network host -t gestion_absences_image:latest -f Dockerfile ."
        '''
      }
    }

    stage('Docker Compose Up') {
      steps {
        echo "→ Lancement des services via docker-compose"
        sh '''
          newgrp docker -c "docker-compose up -d --build"
        '''
      }
    }

    stage('Deploy with Ansible') {
      steps {
        echo "→ Déploiement via Ansible (local)"
        sh '''
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
      echo '❌ Pipeline échouée – logs Docker-Compose :'
      sh 'newgrp docker -c "docker-compose logs --tail=50" || true'
      sh 'newgrp docker -c "docker-compose down --remove-orphans" || true'
    }
  }
}
