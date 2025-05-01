pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'git@github.com:HOUDA1807/gestion_absences.git'
            }
        }
        stage('Deploy') {
            steps {
                sh 'ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml'
            }
        }
    }
}
