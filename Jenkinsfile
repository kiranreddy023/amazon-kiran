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
                def server = Artifactory.server 'kiranjfrog'
                def uploadSpec = '''{
                    "files": [{
                    "pattern": "**/*.jar",
                    "target": "amazon/"
                        }]
                    }'''
                    server.upload(uploadSpec) 
                }
            }
        }
   }
}