pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                script {
                    // Changez le chemin du Dockerfile si nécessaire
                    sh 'docker build -t mon-app ./docker'
                }
            }
        }
        
        stage('Run') {
            steps {
                script {
                    sh 'docker run -d -p 8080:8080 mon-app'
                }
            }
        }
    }
}
