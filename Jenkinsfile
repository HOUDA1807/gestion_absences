pipeline {
    agent any

    environment {
        DOCKER_BUILDKIT = 1
        DOCKER_IMAGE = "gestion_absences_image:latest"
    }

    options {
        // Timeout global : abandonne la pipeline si trop longue (par exemple 30 minutes)
        timeout(time: 30, unit: 'MINUTES')
    }

    stages {
        stage('Build Docker Image') {
            steps {
                echo '→ Build de l\'image Docker'
                sh 'newgrp docker -c "docker build --network host -t $DOCKER_IMAGE -f Dockerfile ."'
            }
        }

        stage('Docker Compose Up') {
            steps {
                echo '→ Lancement des services via docker-compose'
                sh 'newgrp docker -c "docker-compose up -d --build"'
            }
        }

        stage('Deploy with Ansible') {
            steps {
                echo '→ Déploiement via Ansible (local)'
                sh 'newgrp docker -c "ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml --connection=local"'
            }
        }

        stage('Install dependencies') {
            steps {
                echo '→ Mise à jour de pip et installation des dépendances Selenium'
                sh 'newgrp docker -c "pip3 install --upgrade pip"'
                sh 'newgrp docker -c "pip3 install --upgrade selenium"'
            }
        }

        stage('Run Selenium Test') {
            steps {
                echo '→ Exécution du test Selenium'
                // Modification ici pour lancer le test dans le container Docker
                sh 'newgrp docker -c "docker run --rm $DOCKER_IMAGE"'
            }
        }
    }

    post {
        always {
            echo 'Pipeline – logs Docker-Compose :'
            sh 'newgrp docker -c "docker-compose logs --tail=50"'
            sh 'newgrp docker -c "docker-compose down --remove-orphans"'
        }
    }
}
