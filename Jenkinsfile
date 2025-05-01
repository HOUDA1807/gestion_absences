pipeline {
    agent any

    environment {
        // Chemins absolus pour les fichiers et répertoires
        ANSIBLE_CONFIG = '/var/jenkins_home/workspace/Jenkins-Ansible/gestion_absences/ansible/ansible.cfg'
        INVENTORY_FILE = '/var/jenkins_home/workspace/Jenkins-Ansible/gestion_absences/ansible/inventory.ini'
        PLAYBOOK_DIR = '/var/jenkins_home/workspace/Jenkins-Ansible/gestion_absences/ansible/playbooks'
    }

    stages {
        stage('Cloner le dépôt') {
            steps {
                // Cloner le dépôt GitHub dans le workspace Jenkins
                git 'https://github.com/ton-utilisateur/ton-repository.git'
            }
        }

        stage('Préparation') {
            steps {
                // Vérification de la configuration Ansible
                echo "Vérification de la configuration Ansible"
                sh 'ansible --version'
            }
        }

        stage('Exécution des playbooks Ansible') {
            steps {
                // Exécution du playbook avec les chemins absolus
                echo "Exécution du playbook Ansible"
                sh '''
                ansible-playbook -i $INVENTORY_FILE $PLAYBOOK_DIR/ton_playbook.yml
                '''
            }
        }

        stage('Vérification de l\'infrastructure') {
            steps {
                // Vérification de la connexion avec les hôtes
                echo "Vérification de la connexion aux hôtes"
                sh '''
                ansible -i $INVENTORY_FILE all -m ping
                '''
            }
        }
    }

    post {
        success {
            echo 'Le pipeline a réussi !'
        }

        failure {
            echo 'Le pipeline a échoué.'
        }

        always {
            echo 'Exécution du pipeline terminée.'
        }
    }
}
