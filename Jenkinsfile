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
   }
}