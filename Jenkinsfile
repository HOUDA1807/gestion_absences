pipeline {
    agent any
    tools {
        // Spécifie l'installation de Maven configurée dans Jenkins
        maven 'Maven 3'
    }
    environment {
        // Variables d'environnement que tu peux configurer
        DOCKER_IMAGE = 'gestion_absences_image'
        DOCKER_REGISTRY = 'your-docker-registry'
        ANSIBLE_PLAYBOOK = 'deploy.yml'
    }
    stages {
        stage('Declarative: Checkout SCM') {
            steps {
                // Checkout du code depuis le dépôt Git
                checkout scm
            }
        }

        stage('Build Java Project') {
            steps {
                script {
                    // Exécution de Maven pour compiler le projet
                    sh 'mvn clean install'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construction de l'image Docker
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Exécution du conteneur Docker
                    sh 'docker run -d --name gestion_absences $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                script {
                    // Déploiement avec Ansible
                    sh "ansible-playbook -i inventory $ANSIBLE_PLAYBOOK"
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Exécution des tests (par exemple avec Maven ou un autre outil)
                    sh 'mvn test'
                }
            }
        }

        stage('Push to Docker Registry') {
            steps {
                script {
                    // Push de l'image Docker vers un registry
                    sh "docker tag $DOCKER_IMAGE $DOCKER_REGISTRY/$DOCKER_IMAGE"
                    sh "docker push $DOCKER_REGISTRY/$DOCKER_IMAGE"
                }
            }
        }
    }

    post {
        always {
            // Cleanup après chaque exécution du pipeline
            echo 'Pipeline terminé'
            // Ajoute ici des actions de nettoyage si nécessaire (par exemple suppression de conteneurs Docker)
            sh 'docker rm -f gestion_absences'
        }
        success {
            // Actions à effectuer si le pipeline réussit
            echo 'Pipeline réussi !'
        }
        failure {
            // Actions à effectuer si le pipeline échoue
            echo 'Pipeline échoué !'
        }
    }
}
