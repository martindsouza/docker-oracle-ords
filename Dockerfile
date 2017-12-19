# Original source from https://github.com/lucassampsouza/ords_apex
FROM tomcat:8.0-jre8-alpine
MAINTAINER Martin D'Souza <martin@talkapex.com>

ENV TZ="GMT" \
  APEX_CONFIG_DIR="/opt" \
  TOMCAT_HOME="/usr/local/tomcat" \
  APEX_PUBLIC_USER_NAME="APEX_PUBLIC_USER" \
  PLSQL_GATEWAY="true" \
  REST_SERVICES_APEX="true" \
  REST_SERVICES_ORDS="true"

COPY ["ords.war", "config_ords_and_run_catalina.sh", "/tmp/"]
RUN mv /tmp/ords.war $TOMCAT_HOME/webapps/ && \
  mv /tmp/config_ords_and_run_catalina.sh / && \
  mkdir $TOMCAT_HOME/webapps/i && \
  java -jar $TOMCAT_HOME/webapps/ords.war configdir $APEX_CONFIG_DIR && \
  chmod +x /config_ords_and_run_catalina.sh

ENTRYPOINT ["/config_ords_and_run_catalina.sh"]
VOLUME ["/usr/local/tomcat/webapps/i", "/opt"]

EXPOSE 8080

CMD ["run"]
