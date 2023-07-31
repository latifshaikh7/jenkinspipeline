pipeline {
    agent any
    tools {
        maven 'localMaven'
    }

    triggers {
         pollSCM('* * * * *') // Polling Source Control
     }

stages{
        stage('Build Main'){
            when {
                branch 'main'
            }
        
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
        stage ('Deploy to Main'){
            when {
                branch 'main'
            }
        
            steps {
                bat 'xcopy /Y webapp\\target\\*.war C:\\ptc-training\\training\\jenkins\\pipelineascode_tomcat\\apache-tomcat-8.5.91-stage\\webapps'\
            }
        }
        stage('Build to Dev'){
            when {
                branch 'dev'
            }
            
            steps {
                bat 'mvn clean package'
                bat "docker build . -t tomcatwebapp:${env.BUILD_ID}"
            }
        }
 
    }
}



