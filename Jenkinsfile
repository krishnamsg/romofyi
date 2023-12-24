pipeline {
    agent any
    tools {
        jdk "Java17"
        maven "Maven3"
    }
        environment {
        APP_NAME = "romofyi-e2e-pipeline"
        RELEASE = "1.0.0"
        DOCKER_USER = "krishnamsg"
        DOCKER_PASS = 'dockerhub'
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
        JENKINS_API_TOKEN = credentials("JENKINS_API_TOKEN")
      }
      stages {
        stage ('Cleanup Workspace'){
            steps {
                cleanWs()
            }
        }
        stage ('Checkout from SCM') {
            steps {
                git branch: 'dev', credentialsId: 'github', url: 'https://github.com/krishnamsg/romofyi.git'
            }
        }
        stage ('Build Application') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage("Build & Push Docker Image") {
            steps {
                script {
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }

                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }

        }
                 stage("Trigger CD Pipeline") {
            steps {
                script {
                    sh "curl -v -k --user sagar:${JENKINS_API_TOKEN} -X POST -H 'cache-control: no-cache' -H 'content-type: application/x-www-form-urlencoded' --data 'IMAGE_TAG=${IMAGE_TAG}' 'http://10.0.0.100:8080/job/romofyi-kubernetes/buildWithParameters?token=gitops-token'"
                }
            }

        }
      }
}