pipeline {
    agent any

    environment {
        // Variables d'environnement (exemple pour Docker)
        IMAGE_NAME = 'gestion_absences_image'  // Remplace par un nom d'image Docker plus spécifique si tu veux
        DOCKER_REGISTRY = 'docker.io'          // Tu peux laisser cette valeur si tu utilises Docker Hub
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64'  // Garde cette valeur si tu utilises Java 17
    }

    stages {
        stage('Checkout') {
            steps {
                // Récupérer ton code depuis GitHub
                git url: 'https://github.com/HOUDA1807/gestion_absences.git', branch: 'master'

            }
        }

        stage('Build Java Project') {
            steps {
                // Compilation du projet Java
                script {
                    sh 'mvn clean install'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construire une image Docker
                    sh 'docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Lancer un container Docker
                    sh 'docker run -d -p 8080:8080 ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest'
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                script {
                    // Déployer avec Ansible (si configuré)
                    sh 'ansible-playbook -i inventory/production deploy.yml'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Si tu as des tests à effectuer, ajouter ici
                    sh 'mvn test'
                }
            }
        }

        stage('Push to Docker Registry') {
            steps {
                script {
                    // Push de l'image Docker sur un registre Docker Hub
                    sh 'docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline terminé avec succès!'
        }
        failure {
            echo 'Une erreur est survenue durant le pipeline.'
        }
    }
}
