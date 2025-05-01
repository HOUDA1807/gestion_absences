pipeline {
    agent any

    environment {
        // Chemins absolus pour ton environnement Jenkins
        ANSIBLE_PLAYBOOKS_DIR = '/var/jenkins_home/workspace/Jenkins-Ansible/gestion_absences/ansible/playbooks'
        INVENTORY_FILE = '/var/jenkins_home/workspace/Jenkins-Ansible/gestion_absences/ansible/inventory.ini'
        ANSIBLE_CFG = '/var/jenkins_home/workspace/Jenkins-Ansible/gestion_absences/ansible/ansible.cfg'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                script {
                    // Cloner le dépôt Git
                    checkout scm
                }
            }
        }

        stage('Install Ansible') {
            steps {
                script {
                    // Installer Ansible si nécessaire
                    sh 'sudo apt-get update -y'
                    sh 'sudo apt-get install ansible -y'
                }
            }
        }

        stage('Exécution du playbook Ansible - Déploiement') {
            steps {
                script {
                    // Exécuter le playbook de déploiement sur les serveurs de production
                    sh """
                    ansible-playbook -i ${INVENTORY_FILE} ${ANSIBLE_PLAYBOOKS_DIR}/deploy.yml
                    """
                }
            }
        }

        stage('Vérification de l\'infrastructure') {
            steps {
                script {
                    // Vérification d'une tâche simple avec Ansible
                    sh """
                    ansible -i ${INVENTORY_FILE} all -m ping
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline exécuté avec succès.'
        }

        failure {
            echo 'Le pipeline a échoué.'
        }
    }
}
