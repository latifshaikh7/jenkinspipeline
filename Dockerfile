FROM tomcat:8.0

COPY .\webapp\target\webapp.war /user/local/tomcat/webapps/webapp.war

EXPOSE 8080

CMD [ "catalina.sh", "run" ]