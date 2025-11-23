pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'dev', url: 'https://github.com/nermine-sayah/immobilisation-react-devops.git'
            }
        }
    }
}
stage('Setup') {
    steps {
        echo 'Installing dependencies and preparing environment...'
        // Installer Node.js si nécessaire (Jenkins doit avoir Node installé ou utiliser un Node tool)
        sh 'node -v'
        sh 'npm -v'
        
        // Vérifier Docker
        sh 'docker --version'
    }
}
stage('Build') {
    steps {
        echo 'Building React app...'
        // Installer les dépendances React
        sh 'npm ci'
        // Build de l'application React
        sh 'npm run build'

        echo 'Building Docker image...'
        // Construire l'image Docker
        sh 'docker build -t immobilisation-react:latest .'
    }
}
stage('Run Docker') {
    steps {
        echo 'Running Docker container...'
        // Stop et supprimer le conteneur précédent si existant
        sh 'docker rm -f immobilisation-react || true'
        // Lancer le conteneur sur le port 8080
        sh 'docker run -d --name immobilisation-react -p 8080:80 immobilisation-react:latest'
    }
}
stage('Smoke Test') {
    steps {
        echo 'Running smoke tests...'
        // Vérifier que le conteneur répond sur le port 8080
        sh 'curl -f http://localhost:8080 || exit 1'
    }
}
stage('Archive Artifacts') {
    steps {
        echo 'Archiving build artifacts...'
        archiveArtifacts artifacts: 'build/**', fingerprint: true
        archiveArtifacts artifacts: '**/*.log', allowEmptyArchive: true
    }
}
