pipeline{
   agent any
   tools{
    maven "maven-3.6.3"
    
   }
   environment{
        imageName = "kiran023/amazon"        
        registryUrl = "registry.hub.docker.com"
        registryCreds = 'docker'
        dockerImage = ''
    }
   stages{
        stage("mvn test"){
            steps{
            sh 'mvn clean test'
            }
        }
        stage("sonar-check"){
            steps{
                echo "sonar analysis test"
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
                script {
                    dir("Amazon-Web"){
                        dockerImage = docker.build imageName
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                // Push the Docker image to a container registry
                script {
                    docker.withRegistry("https://${registryUrl}", registryCreds) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage("deploy-tomcat"){
            steps{
                sh "rm -f /opt/tomcat/webapps/*.war"
                sh "cp **/**/*.war /opt/tomcat/webapps/"
                sh 'bash /opt/tomcat/bin/startup.sh'
            }
        }
        stage('deploy-docker'){
            steps{
                sh 'docker run -dp 9090:8080 --name amazonimage dockerImage'
            }
        }
   }
}