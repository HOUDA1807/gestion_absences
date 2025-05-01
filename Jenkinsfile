pipeline {
    agent any

    stages {
        stage('Checkout code') {
            steps {
                git credentialsId: 'jenkins-github-sec-key',
                    url: 'git@github.com:HOUDA1807/gestion_absences.git'
            }
        }

        stage('Check dependencies') {
            steps {
                sh 'which ansible || { echo "Ansible is not installed"; exit 1; }'
                sh 'which git || { echo "Git is not installed"; exit 1; }'
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'jenkins-github-sec-key', keyFileVariable: 'SSH_KEY')]) {
                    sh 'ansible-playbook -i ansible/inventory.ini --private-key=$SSH_KEY ansible/playbooks/deploy.yml'
                }
            }
        }
    }

    post {
        always {
            echo 'Nettoyage des ressources...'
        }
        failure {
            echo 'Le pipeline a échoué.'
        }
        success {
            echo 'Déploiement terminé avec succès.'
        }
    }
}
