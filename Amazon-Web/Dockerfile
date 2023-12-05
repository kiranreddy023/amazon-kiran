FROM tomcat:10
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/
COPY target/Amazon.war /usr/local/tomcat/webapps/Amazon.war
EXPOSE 8080
