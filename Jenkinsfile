pipeline {
    agent any

    environment {
        // Chemin vers le fichier de config Ansible si tu l'utilises
        ANSIBLE_CONFIG = "${WORKSPACE}/ansible/ansible.cfg"
    }

    stages {
        stage('📥 Clonage du dépôt') {
            steps {
                git branch: 'master', 
                    url: 'git@github.com:HOUDA1807/gestion_absences.git', 
                    credentialsId: 'jenkins-github-sec-key'
            }
        }

        stage('📦 Exécution du playbook Ansible') {
            steps {
                dir('ansible') {
                    sh 'ansible-playbook playbooks/playbook.yml -i inventory.ini'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Playbook exécuté avec succès.'
        }
        failure {
            echo '❌ Échec de l’exécution du playbook.'
        }
    }
}
