pipeline {
    agent any

    environment {
        APP_NAME = "hello-api"
        IMAGE_NAME = "hello-api:latest"
        KIND_CLUSTER = "hello-cluster"
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "Cloning source code from Git"
                git branch: 'main', url: 'https://github.com/viennak/open-apis.git'
            }
        }

        stage('Build Application') {
            steps {
                echo "Building application"
                bat 'mvn clean package -DskipTests'
                // macOS/Linux:
                // sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image"
                bat "docker build -t %IMAGE_NAME% ."
                // macOS/Linux:
                // sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Load Image into kind') {
            steps {
                echo "Loading Docker image into kind cluster"
                bat "kind load docker-image %IMAGE_NAME% --name %KIND_CLUSTER%"
                // macOS/Linux:
                // sh "kind load docker-image ${IMAGE_NAME} --name ${KIND_CLUSTER}"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo "Deploying application to Kubernetes"
                bat "kubectl apply -f k8s/"
                // macOS/Linux:
                // sh "kubectl apply -f k8s/"
            }
        }

        stage('Verify Deployment') {
            steps {
                echo "Checking pods and services"
                bat "kubectl get pods"
                bat "kubectl get svc"
            }
        }
    }

    post {
        success {
            echo "🎉 Deployment completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check logs."
        }
    }
}
