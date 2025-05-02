pipeline { 
  agent any

  environment {
    // Désactive BuildKit pour éviter certains problèmes liés aux DNS dans Jenkins
    DOCKER_BUILDKIT = '0'
    // Force Docker à utiliser le réseau de l'hôte (utile pour certains contextes locaux)
    DOCKER_NETWORK = 'host'
    // Ajoute le chemin de Docker si besoin
    PATH = "/usr/bin:${env.PATH}"pipeline { 
  agent any

  environment {
    // Désactive BuildKit pour éviter certains problèmes liés aux DNS dans Jenkins
    DOCKER_BUILDKIT = '0'
    // Force Docker à utiliser le réseau de l'hôte (utile pour certains contextes locaux)
    DOCKER_NETWORK = 'host'
    // Ajoute le chemin de Docker si besoin
    PATH = "/usr/bin:${env.PATH}"
  }

  stages {

    stage('Vérification Docker') {
      steps {
        script {
          sh 'docker --version'
          sh 'docker compose version'
        }
      }
    }

    stage('Checkout du dépôt Git') {
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

    stage('Installation des dépendances Node.js') {
      steps {
        dir('app') {
          sh 'npm install --production'
        }
      }
    }

    stage('Construction de l\'image Docker') {
      steps {
        sh '''
          echo "→ Construction de l'image Docker"
          DOCKER_BUILDKIT=${DOCKER_BUILDKIT} \
            docker build --network ${DOCKER_NETWORK} \
              -t gestion_absences_image:latest \
              -f Dockerfile .
        '''
      }
    }

    stage('Lancement avec Docker Compose') {
      steps {
        sh '''
          echo "→ Lancement des conteneurs avec Docker Compose"
          docker compose up -d --build
        '''
      }
    }

    stage('Déploiement avec Ansible') {
      steps {
        sh '''
          echo "→ Exécution du playbook Ansible"
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
      echo '❌ Pipeline échouée.'
      sh 'docker compose logs || true'
      sh 'docker compose down --remove-orphans || true'
    }
  }
}

  }

  stages {

    stage('Vérification Docker') {
      steps {
        script {
          sh 'docker --version'
          sh 'docker compose version'
        }
      }
    }

    stage('Checkout du dépôt Git') {
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

    stage('Installation des dépendances Node.js') {
      steps {
        dir('app') {
          sh 'npm install --production'
        }
      }
    }

    stage('Construction de l\'image Docker') {
      steps {
        sh '''
          echo "→ Construction de l'image Docker"
          DOCKER_BUILDKIT=${DOCKER_BUILDKIT} \
            docker build --network ${DOCKER_NETWORK} \
              -t gestion_absences_image:latest \
              -f Dockerfile .
        '''
      }
    }

    stage('Lancement avec Docker Compose') {
      steps {
        sh '''
          echo "→ Lancement des conteneurs avec Docker Compose"
          docker compose up -d --build
        '''
      }
    }

    stage('Déploiement avec Ansible') {
      steps {
        sh '''
          echo "→ Exécution du playbook Ansible"
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
      echo '❌ Pipeline échouée.'
      sh 'docker compose logs || true'
      sh 'docker compose down --remove-orphans || true'
    }
  }
}
