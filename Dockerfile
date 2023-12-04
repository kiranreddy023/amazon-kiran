FROM tomcat:10
COPY Amazon-Web/target/Amazon.war /usr/local/tomcat/webapps/Amazon.war
EXPOSE 8080
