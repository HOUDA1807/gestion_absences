pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'jenkins-github-sec-key', url: 'https://github.com/HOUDA1807/gestion_absences.git'
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                sh 'ansible-playbook -i inventory.ini playbook.yml'
            }
        }
    }
}
