pipeline {
    agent any
    
    tools {
        nodejs 'node22'
    }
    
    environment {
        SONARQUBE_SCANNER= tool 'sonar-scanner'
    }
    
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', credentialsId: 'github-credentials', url: 'https://github.com/iam-aniket-dutta/DevSecOps_Project_3Tier_App.git'
            }
        }
        
        stage('Install dependancies(npm pacakges)') {
            steps {
                sh 'npm install'
            }
        }
        
        stage('Unit Tests') {
            steps {
                sh 'npm test'
            }
        }
        
        stage('Trivy File Sytem Scan') {
            steps {
                sh 'trivy fs --format table -o fs-report.html .'
            }
        }
        
        stage('Sonar Qube Scan') {
            steps {
                withSonarQubeEnv('sonarqube-server') {
                    sh ' $SONARQUBE_SCANNER/bin/sonar-scanner -Dsonar.projectKey=Campground -Dsonar.projectName=Campground'
                }
            }
        }
        
         stage('Docker build image') {
            steps {
               script{
                   withDockerRegistry(credentialsId: 'docker-credentials', toolName: 'docker') {
                        sh 'docker build -t aniketnitu2026/3tier-app:latest .'
                    }
               }
            }
        }
        
        stage('Trivy Docak Image Scan') {
            steps {
                sh 'trivy image --format table -o image-report.html aniketnitu2026/3tier-app:latest'
            }
        }
        
        stage('Docker Push image') {
            steps {
               script{
                   withDockerRegistry(credentialsId: 'docker-credentials', toolName: 'docker') {
                        sh 'docker push aniketnitu2026/3tier-app:latest'
                    }
               }
            }
        }
        
        stage('Docker Deployment for Dev Env') {
            steps {
               script{
                   withDockerRegistry(credentialsId: 'docker-credentials', toolName: 'docker') {
                        sh 'docker run -d -p 3000:3000  aniketnitu2026/3tier-app:latest'
                    }
               }
            }
        }
    }
}
