pipeline {
    agent any

    stages {
        stage('Checkout code') {
            steps {
                git credentialsId: 'jenkins-github-sec-key',
                    url: 'git@github.com:HOUDA1807/gestion_absences.git'
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh 'ansible-playbook ansible/deploy.yml'
            }
        }
    }

    post {
        failure {
            echo 'Le pipeline a échoué.'
        }
        success {
            echo 'Déploiement terminé avec succès.'
        }
    }
}
