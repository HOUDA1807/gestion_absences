pipeline {
    agent any

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'git@github.com:ton_utilisateur/ton_projet.git', credentialsId: 'ansible_ssh_key'
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh '''
                    ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml \
                    --private-key ~/.ssh/id_ed25519
                '''
            }
        }
    }
}
