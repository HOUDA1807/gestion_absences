pipeline {
  agent any

  environment {
    PATH         = "/usr/bin:${env.PATH}"
    DOCKER_HOST  = "tcp://172.21.68.21:2375"
  }

  stages {
    stage('Checkout') {
      steps {
        // Récupère exactement le même repo et Jenkinsfile que tu as configuré
        checkout scm
      }
    }

    stage('Verify Docker') {
      steps {
        sh '''
          echo "→ docker --version" 
          docker --version
          echo "→ docker info"
          docker info
        '''
      }
    }

    stage('Build Docker Image') {
      steps {
        dir("${WORKSPACE}") {
          sh '''
            echo "→ build image from root Dockerfile"
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
        dir("${WORKSPACE}") {
          sh '''
            echo "→ docker compose up"
            docker compose \
              -f docker-compose.yml \
              up -d
          '''
        }
      }
    }

    stage('Deploy with Ansible') {
      steps {
        dir("${WORKSPACE}") {
          sh '''
            echo "→ ansible-playbook deploy"
            ansible-playbook \
              -i ansible/inventory.ini \
              ansible/playbooks/deploy.yml
          '''
        }
      }
    }
  }

  post {
    always {
      // On shutdown juste l'app de la CI, pas ton conteneur Jenkins !
      dir("${WORKSPACE}") {
        sh '''
          echo "→ docker compose down"
          docker compose \
            -f docker-compose.yml \
            down --remove-orphans || true
        '''
      }
    }
    success {
      echo "✅ Pipeline terminée avec succès"
    }
    failure {
      echo "❌ Pipeline échouée, regarde les logs ci-dessus"
    }
  }
}

