pipeline {
    agent any

    environment {
        ANSIBLE_PLAYBOOK = "gestion_absences/ansible/playbooks/deploy.yml"
        INVENTORY_FILE = "gestion_absences/ansible/inventory.ini"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Exécution du playbook Ansible - Déploiement') {
            steps {
                script {
                    sh "ansible-playbook -i ${INVENTORY_FILE} ${ANSIBLE_PLAYBOOK}"
                }
            }
        }
    }

    post {
        failure {
            echo "❌ Le pipeline a échoué."
        }
        success {
            echo "✅ Déploiement effectué avec succès via Ansible !"
        }
    }
}
