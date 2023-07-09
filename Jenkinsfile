pipeline{
	agent any
	tools{
		maven "maven-3.6.3"
	}
	stages{
		stage("mvn build"){
			steps{
				sh "mvn clean package -DskipTests=true"
			}
		}
		stage("mvn test"){
            steps{
                sh "mvn test"
            }
        }
		stage("docker build"){
            steps{
                sh "docker build -t kiran023/amazon:v1 ."
            }
        }
		stage("docker run"){
            steps{
                sh "docker run -dp 9091:8080 --name amazon kiran023/amazon:v1"
            }
        }				
	}
}
