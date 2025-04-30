pipeline {
    agent any

    environment {
        ANSIBLE_HOST_KEY_CHECKING = "false"  // Désactive la vérification de l'empreinte de la clé SSH (optionnel)
    }

    stages {
        stage('Checkout SCM') {
            steps {
                // Récupère les fichiers du dépôt Git
                checkout scm
            }
        }

        stage('Hello') {
            steps {
                script {
                    // Affiche les versions des outils Ansible pour s'assurer qu'ils sont bien installés
                    sh 'ansible --version'
                    sh 'ansible-playbook --version'
                }
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                script {
                    // Exécute le playbook Ansible
                    sh 'ansible-playbook -i inventory.ini playbook.yml'
                }
            }
        }
    }

    post {
        always {
            // Actions après la fin du build (optionnel)
            echo 'Pipeline finished!'
        }
    }
}
