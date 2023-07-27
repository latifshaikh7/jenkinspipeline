pipeline {
    agent any
    tools {
        maven 'localMaven'
    }

    triggers {
         pollSCM('* * * * *') // Polling Source Control
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
                bat "xcopy **/target/*.war C:\ptc-training\training\jenkins\apache-tomcat-8.5.91-stage\webapps\"
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
