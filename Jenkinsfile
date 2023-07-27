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
                bat 'start cmd.exe /c C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Pipelinecode-job\\webapp\\target\\*.war C:\\ptc-training\\training\\jenkins\\pipelineascode_tomcat\\apache-tomcat-8.5.91-stage\\webapps'\
            }
        }
        stage ('Deploy to Production'){
            steps{
                timeout(time:5, unit:'DAYS'){
                    input message:'Approve PRODUCTION DEPLOYMENT?'
                }
                bat 'start cmd.exe /c C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Pipelinecode-job\\webapp\\target\\*.war C:\\ptc-training\\training\\jenkins\\pipelineascode_tomcat\\apache-tomcat-8.5.91-prod\\webapps'\
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
