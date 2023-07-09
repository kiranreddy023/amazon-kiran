FROM alpine:3.15
MAINTAINER Kiran Vepanjeri
RUN apt update && apt install default-jre -y
WORKDIR /opt/
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.76/bin/apache-tomcat-9.0.76.tar.gz
RUN tar -xf apache-tomcat-9.0.76.tar.gz
RUN mv apache-tomcat-9.0.76 tomcat
COPY target/*.war ./tomcat/webapps/
EXPOSE 8080
CMD ["./tomcat/bin/catalina.sh","run"]


