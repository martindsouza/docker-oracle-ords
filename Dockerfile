# Original source from https://github.com/lucassampsouza/ords_apex
FROM openjdk:8-jre-alpine
LABEL maintainer="Martin DSouza <martin@talkapex.com>"

ENV TZ="GMT" \
  APEX_CONFIG_DIR="/opt" \
  TOMCAT_HOME="/usr/local/tomcat" \
  APEX_PUBLIC_USER_NAME="APEX_PUBLIC_USER" \
  PLSQL_GATEWAY="true" \
  REST_SERVICES_APEX="true" \
  REST_SERVICES_ORDS="true" \
  MIGRATE_APEX_REST="true" \
  # SQL Developer Web and REST enabled SQL
  FEATURE_SDW="true" \ 
  REST_SQL="true" \
  ORDS_DIR="/ords"

WORKDIR ${ORDS_DIR}

COPY ["files/ords-*.zip", "scripts/*", "/tmp/"]

RUN echo "" && \
  unzip /tmp/ords-*.zip ords.war && \
  rm -rf /tmp/ords-*.zip && \
  chmod +x /tmp/docker-run.sh && \
  /tmp/docker-run.sh

ENTRYPOINT ["/ords/config-run-ords.sh"]

VOLUME ["/ords/apex-images", "/opt/ords"]

EXPOSE 8080

HEALTHCHECK --start-period=10s --interval=5s --retries=5 CMD curl --fail http://localhost:8080/ords || exit 1

CMD ["run"]
