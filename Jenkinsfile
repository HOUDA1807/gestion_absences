pipeline {
  agent {
    docker {
      image 'willhallonline/ansible:latest'
    }
  }

  stages {
    stage('Ansible version') {
      steps {
        sh 'ansible --version'
      }
    }
  }
}
