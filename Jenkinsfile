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
        stage ('Build Application') {
            steps {
                sh 'mvn clean install'
            }
        }
      }
}