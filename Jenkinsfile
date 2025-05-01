pipeline {
    agent any

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {
        stage('Checkout code') {
            steps {
                git url: 'git@github.com:HOUDA1807/gestion_absences.git',
                    credentialsId: 'jenkins-github-sec-key'
            }
        }

        stage('Install Ansible (optional)') {
            steps {
                sh '''
                if ! command -v ansible-playbook &> /dev/null; then
                    echo "Installing Ansible..."
                    sudo apt-get update
                    sudo apt-get install -y ansible
                else
                    echo "Ansible already installed."
                fi
                '''
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh '''
                ansible-playbook -i ansible/inventory.ini ansible/playbook.yml \
                    --private-key ~/.ssh/id_ed25519
                '''
            }
        }
    }
}
