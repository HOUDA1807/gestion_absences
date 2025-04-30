pipeline {
    agent any

    environment {
        ANSIBLE_CONFIG = "${WORKSPACE}/ansible/ansible.cfg"
    }

    stages {
        stage('Vérification du code') {
            steps {
                git branch: 'master', url: 'git@github.com:HOUDA1807/gestion_absences.git', credentialsId: 'jenkins-github-sec-key'
            }
        }

        stage('Exécution du playbook Ansible') {
            steps {
                sh 'ansible-playbook ansible/playbooks/playbook.yml -i ansible/inventory.ini'
            }
        }
    }

    post {
        failure {
            echo '❌ Échec de l’exécution du playbook.'
        }
        success {
            echo '✅ Playbook exécuté avec succès.'
        }
    }
}
