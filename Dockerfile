# Original source from https://github.com/lucassampsouza/ords_apex
FROM openjdk:8-jre-alpine
MAINTAINER Martin DSouza <martin@talkapex.com>

ENV TZ="GMT" \
  APEX_CONFIG_DIR="/opt" \
  TOMCAT_HOME="/usr/local/tomcat" \
  APEX_PUBLIC_USER_NAME="APEX_PUBLIC_USER" \
  PLSQL_GATEWAY="true" \
  REST_SERVICES_APEX="false" \
  REST_SERVICES_ORDS="true" \
  MIGRATE_APEX_REST="true" \
  ORDS_DIR="/ords"

COPY ["ords.war", "config-run-ords.sh", "/tmp/"]

WORKDIR ${ORDS_DIR}

RUN mkdir $ORDS_DIR/params && \
  mkdir $ORDS_DIR/apex-images && \
  mv /tmp/config-run-ords.sh $ORDS_DIR/ && \
  mv /tmp/ords.war $ORDS_DIR/ && \
  chmod +x $ORDS_DIR/config-run-ords.sh && \
  java -jar ords.war configdir $APEX_CONFIG_DIR

ENTRYPOINT ["/ords/config-run-ords.sh"]

VOLUME ["/ords/apex-images", "/opt/ords"]

EXPOSE 8080

CMD ["run"]
