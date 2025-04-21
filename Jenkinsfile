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
                git credentialsId: '1', url: 'git@github.com:HOUDA1807/gestion_absences.git'
                // Remplacez 'git@github.com:HOUDA1807/gestion_absences.git' si vous utilisez SSH
                // Utilisez 'https://github.com/HOUDA1807/gestion_absences.git' si vous utilisez un token
            }
        }

        stage('Build') {
            steps {
                echo "Début de la phase de construction..."
                // Adaptez ces commandes en fonction de votre projet (par exemple, Maven, Gradle, npm...)
                sh 'echo "Aucune étape de construction spécifique requise pour ce projet."'
            }
        }

        stage('Test') {
            steps {
                echo "Début de la phase de test..."
                // Adaptez ces commandes en fonction de votre projet (par exemple, JUnit, Jest...)
                sh 'echo "Aucune étape de test spécifique requise pour ce projet."'
            }
        }

        stage('Deploy') {
            steps {
                echo "Début de la phase de déploiement..."
                // Adaptez ces commandes en fonction de votre environnement de déploiement
                // Par exemple : docker login, docker push, kubectl apply...
                sh 'echo "Aucune étape de déploiement spécifique définie. Vérifiez la configuration Docker."'
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