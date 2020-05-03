@Library('github.com/devops-genuine/shared-jenkins-library@master') _

pipeline {
    agent { label "master" }
    tools {
        maven 'Maven 3.6.3'
    }

    parameters {
        string(name: 'APP_NAME', defaultValue: 'demoapp', description: 'You Application Name')
        string(name: 'REPO_NAME', defaultValue: '980259306743.dkr.ecr.ap-southeast-1.amazonaws.com',description: 'You Repo Name')
    }

    stages {
        stage ('Build Jar') {
            steps {
                sh 'mvn -Dmaven.test.failure.ignore=true clean package' 
            }
            post {
                success {
                    junit 'target/surefire-reports/**/*.xml' 
                }
            }
        }
        stage ('Build Docker Image') {
            steps {
                script {
                    buildImage(currentBuild,params.REPO_NAME,params.APP_NAME)
                }
            }
        }
        stage ('Helm Deploy') {
            steps {
                sh 'hostname' 
            }
        }
    }
    post {
        always {
            script {
                sendEmail(currentBuild, ['testemail@domain.tld'])
            }
        }
    }
}