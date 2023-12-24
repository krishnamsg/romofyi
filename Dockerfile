FROM maven:3.9.0-eclipse-temurin-17 as build
WORKDIR /app
COPY . .
RUN mvn clean install
FROM tomcat:8.0-alpine

LABEL maintainer=”deepak@softwareyoga.com”

ADD *.war /usr/local/tomcat/webapps/ROOT

EXPOSE 8080

CMD [“catalina.sh”, “run”]