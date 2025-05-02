**Nouveau Jenkinsfile & Dockerfile pour Agent Jenkins**

Voici les deux fichiers à ajouter dans ton dépôt pour disposer d'un agent Jenkins capable d'exécuter **Node**, **Docker**, **docker‑compose** et **Ansible** sans SSH :

---

### 1. `Jenkinsfile`

```groovy
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
```

---

### 2. `jenkins-agent.Dockerfile`

```dockerfile
# Image de base avec Docker CLI
FROM docker:24.0.5-cli

# Installer python3, pip, Node.js, npm, Ansible et docker-compose
RUN apk add --no-cache \
      python3 py3-pip nodejs npm openssh-client git \
    && pip3 install --no-cache-dir ansible docker-compose \
    && npm install -g npm@latest

# Répertoire de travail (facultatif)
WORKDIR /workspace
```

---

#### 📝 Inventaire Ansible pour déploiement local

Dans `ansible/inventory.ini`, cible localhost :

```ini
[local]
127.0.0.1 ansible_connection=local
```

Avec ces deux fichiers et l'inventaire, ton pipeline Jenkins :

* monte l'image agent personnalisée
* contrôle le démon Docker de l'hôte via le socket
* dispose de `npm`, `docker-compose`, `ansible` prêts à l'emploi

**Teste et dis-moi** si tu as besoin d'ajustements (chemins, versions, etc.).
