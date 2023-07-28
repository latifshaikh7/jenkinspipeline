FROM tomcat:8.0

COPY ./webapp/target/*.war /user/local/tomcat/webapps/

EXPOSE 8080

CMD [ "catalina.sh", "run" ]