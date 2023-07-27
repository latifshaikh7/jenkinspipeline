pipeline {
    agent any
    tools {
        maven 'localMaven'
    }
stages{
        stage('Build'){
            steps {
                bat 'mvn clean package'
            }
            post {
                success {
                    echo 'Now Archiving...'
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }
        stage ('Deploy to Staging') {
            steps {
                build job: 'Deploy-to-staging'
            }
        }
        stage ('Deploy to Production'){
            steps{
                timeout(time:5, unit:'DAYS'){
                    input message:'Approve PRODUCTION DEPLOYMENT?'
                }
                build job: 'Deploy-to-prod'
            }
            post{
                success {
                    echo 'Code Deployed to Production'
                }
                failure {
                    echo 'Deployment failed.'
                }
            }
        }


    }
}
