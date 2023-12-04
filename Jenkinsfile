pipeline{
   agent any
   tools{
    maven "maven-3.6.3"
    
   }
   environment{
        imageNameAmazon = "kiran023/amazon:latest"
        registryUrl = "registry.hub.docker.com"
        registryCreds = 'docker'
        dockerImageAmazon = ''
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
        stage('dockerbuild'){
            steps{
                script{            
                        dockerImageAmazon = docker.build imageNameAmazon
                }
            }
        }
   }
}