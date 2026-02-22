pipeline {
    agent any
    
    tools {
        nodejs 'node21'
    }
    
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', credentialsId: 'git-credntials', url: 'https://github.com/iam-aniket-dutta/DevSecOps_Project_3Tier_App.git'
            }
        }
        
        stage('Install dependancies(npm pacakges)') {
            steps {
                sh 'npm install'
            }
        }
        
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
        
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
    }
}
