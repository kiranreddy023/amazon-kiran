pipeline{
   agent any
   tools{
    maven "maven-3.6.3"
    
   }
   
   stages{
        stage("mvn test"){
            steps{
            sh 'mvn clean test'
            }
        }
        stage("sonar-check"){
            steps{
                echo "sonar analysis"
            }
        }
        stage('mvn package'){
            steps{
                sh 'mvn clean package -DskipTests=true'
            }
        }
        stage ('Upload to jfrog') {
            steps {
               script {
                def server = Artifactory.server 'jfrog'
                def uploadSpec = '''{
                    "files": [{
                    "pattern": "**/*.war",
                    "target": "amazon/"
                        }]
                    }'''
                    server.upload(uploadSpec) 
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                // Define the Dockerfile path
                // def dockerfilePath = "./Amazon-Web/"

                // Build the Docker image
                script {
                    dockerImage = docker.build("kiran023/amazon:latest", "-f Amazon-Web/Dockerfile")
                }
            }
        }
   }
}