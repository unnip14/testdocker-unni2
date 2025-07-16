pipeline {
  agent any

  environment {
    IMAGE = "yourdockerhub/php-cicd-demo"
  }

  stages {
    stage('Clone Code') {
      steps {
        git 'https://github.com/unnip14/testdocker-unni2.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $IMAGE:latest .'
      }
    }

    stage('Push Docker Image') {
      steps {
        withCredentials([string(credentialsId: 'dockerhub-password', variable: 'DOCKER_PASS')]) {
          sh """
          echo $DOCKER_PASS | docker login -u yourdockerhub --password-stdin
          docker push $IMAGE:latest
          """
        }
      }
    }

    stage('Deploy on Server') {
      steps {
        sshagent(credentials: ['be9e12b9-c6d5-4368-a87e-849283780382']) {
          sh 'ssh ubuntu@172.31.82.42 "docker pull $IMAGE:latest && docker stop phpapp || true && docker rm phpapp || true && docker run -d -p 80:80 --name phpapp $IMAGE:latest"'
        }
      }
    }
  }
}
