pipeline {
    agent any
    tools {
        maven 'Maven 3.6.2'
        jdk 'JDK 8'
    }
    environment {
        GITLAB = credentials('a31843c7-9aa6-4723-95ff-87a1feb934a1')
        AWS_CREDS = credentials('aws-adam-iam')
    }
    stages {
        stage('Parameters Set-up') {
            steps {
                script {
                    properties([
                        disableConcurrentBuilds(), 
                        gitLabConnection(gitLabConnection: 'GitLab API Connection', jobCredentialId: ''),
                        [$class: 'GitLabPushTrigger', branchFilterType: 'feature/*', triggerOnPush: true, triggerOnMergeRequest: false, ciSkip: true, includeBranchesSpec: "feature/*", excludeBranchesSpec: '', setBuildDescription: true]
                    ])
                }
            }
        }
        stage('Initialization') {
            steps {
                script {
                    sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                    mvn validate
                    mvn initialize
                    '''
                    echo 'Maven CI job has been validated and initialized.'
                }
                
            }
        }
        stage('Compilation') {
            steps {
                script {
                    sh 'mvn compile'
                    echo 'Maven CI job has been compiled.'
                } 
            }
        }
        stage('Unit tests') {
            steps {
                script {
                    sh '''
                    mvn test
                    '''
                    echo "Unit tests for maven CI job have been passed."
                } 
            }
        }
        stage('Packaging') {
            steps {
                script {
                    sh '''
                    mvn package
                    '''
                    echo "An artifact for maven CI job has been created."
                } 
            }
        }    
        stage('Publishing to artifactory') {
            steps {
                script {
                    sh '''
                    mvn deploy -DskipTests
                    '''
                    echo "An artifact for maven CI job has been created."
                } 
            }
        }
    }
}