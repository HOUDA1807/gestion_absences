pipeline {
    agent any

    triggers {
        githubPush()
    }

    options {
        timestamps()
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: '2', url: 'git@github.com:HOUDA1807/gestion_absences.git'
                // Utilise l'URL SSH (git@github.com:...) et Remplacez '1' par l'ID de vos identifiants GitHub
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "🔧 Installation des dépendances avec npm..."
                // Installer Node.js et npm si non présents
                sh '''
                    curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
                    apt-get install -y nodejs
                '''
                // Maintenant installer les dépendances
                sh 'npm install'
            }
        }

        stage('Build') {
            steps {
                echo "🛠️ Construction du projet..."
                sh 'npm run build' // Adapté à ton projet
            }
        }

        stage('Test') {
            steps {
                echo "🧪 Exécution des tests..."
                // Ajouter ici des tests si nécessaires
                sh 'npm run test' // Adapté à ton projet
            }
        }

        stage('Deploy') {
            steps {
                echo "🚀 Déploiement..."
                // Ajouter des étapes de déploiement, par exemple, avec Docker
                sh 'npm run deploy' // Adapté à ton projet
            }
        }
    }

    post {
        success {
            echo 'La pipeline a été exécutée avec succès !'
        }
        failure {
            echo 'La pipeline a échoué !'
        }
    }
}