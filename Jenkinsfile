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
	}
}
