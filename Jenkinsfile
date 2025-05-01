pipeline {
    agent any

    environment {
        ANSIBLE_FORCE_COLOR = 'true'
        TERM = 'xterm-256color'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                git branch: 'master',
                    url: 'git@github.com:HOUDA1807/gestion_absences.git',
                    credentialsId: 'jenkins-github-sec-key'
            }
        }

        stage('Exécution du playbook Ansible - Déploiement') {
            steps {
                script {
                    sh '''
                        cd ansible
                        ansible-playbook -i inventory.ini playbooks/deploy.yml
                    '''
                }
            }
        }
    }

    post {
        failure {
            echo "❌ Le pipeline a échoué."
        }
        success {
            echo "✅ Le pipeline s'est terminé avec succès."
        }
    }
}
