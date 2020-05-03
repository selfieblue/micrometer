@Library('github.com/devops-genuine/shared-jenkins-library@master') _

pipeline {
    agent { label "master" }
    tools {
        maven 'Maven 3.6.3'
    }

    parameters {
        string(name: 'RELEASE_VERSION', defaultValue: '1.0.0', description: 'Release Version')
        string(name: 'APP_NAME', defaultValue: 'demoapp', description: 'You Application Name')
        string(name: 'REPO_NAME', defaultValue: '980259306743.dkr.ecr.ap-southeast-1.amazonaws.com',description: 'You Repo Name')
        string(name: 'KUBE_NAMESPACE', defaultValue: 'dev',description: 'Target Kubernetes Namespace')
    }

    stages {
        stage ('Build Jar') {
            steps {
                sh 'mvn -Dmaven.test.failure.ignore=true clean package' 
            }
            // post {
            //     success {
            //         junit 'target/surefire-reports/**/*.xml' 
            //     }
            // }
        }
        stage ('Build Docker Image') {
            steps {
                script {
                    buildAndPushImage(params.REPO_NAME,params.APP_NAME,params.RELEASE_VERSION)
                }
            }
        }
        // stage ('Helm Deploy') {
        //     steps {
        //         script {
        //             helmDeploy(currentBuild,params.REPO_NAME,params.APP_NAME,params.RELEASE_VERSION,params.KUBE_NAMESPACE)
        //         }
        //     }
        // }
    }
    post {
        always {
            script {
                sendEmail(currentBuild, ['testemail@domain.tld'])
            }
        }
    }
}