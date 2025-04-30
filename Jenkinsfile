pipeline {
    agent any

    environment {
        // Ajout explicite du chemin vers sudo
        PATH = "/usr/bin:$PATH"
    }

    stages {
        stage('Declarative: Checkout SCM') {
            steps {
                checkout scm
            }
        }
        
        stage('📥 Clonage du dépôt') {
            steps {
                script {
                    // On clone le dépôt Git
                    sh 'git clone git@github.com:HOUDA1807/gestion_absences.git'
                }
            }
        }

        stage('📦 Exécution du playbook Ansible') {
            steps {
                dir('ansible') {
                    script {
                        // Exécution du playbook Ansible avec le chemin modifié pour sudo
                        sh 'ansible-playbook playbooks/playbook.yml -i inventory.ini'
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline terminé."
        }
        failure {
            echo "❌ Échec de l’exécution du playbook."
        }
    }
}
