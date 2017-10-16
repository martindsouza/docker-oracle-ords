#!/bin/bash
set -e

file="/opt/ords"
if [ -d "$file" ]
then
	echo "$file found."
else
	echo "$file not found."
	mkdir $TOMCAT_HOME/webapps/params

	echo "db.hostname=$DB_HOSTNAME" >> $TOMCAT_HOME/webapps/params/ords_params.properties
	echo "db.password=$APEX_PUBLIC_USER_PASS" >> $TOMCAT_HOME/webapps/params/ords_params.properties
	echo "db.port=$DB_PORT" >> $TOMCAT_HOME/webapps/params/ords_params.properties
	echo "db.servicename=$DB_SERVICENAME" >> $TOMCAT_HOME/webapps/params/ords_params.properties
	echo "db.sid=$DATABASE_SID" >> $TOMCAT_HOME/webapps/params/ords_params.properties
	echo "db.username=$APEX_PUBLIC_USER_NAME" >> $TOMCAT_HOME/webapps/params/ords_params.properties
	echo "migrate.apex.rest=false" >> $TOMCAT_HOME/webapps/params/ords_params.properties
	echo "plsql.gateway.add=$PLSQL_GATEWAY" >> $TOMCAT_HOME/webapps/params/ords_params.properties
	echo "rest.services.apex.add=$REST_SERVICES_APEX" >> $TOMCAT_HOME/webapps/params/ords_params.properties
	echo "rest.services.ords.add=$REST_SERVICES_ORDS" >> $TOMCAT_HOME/webapps/params/ords_params.properties
	echo "standalone.mode=false" >> $TOMCAT_HOME/webapps/params/ords_params.properties
	echo "user.apex.listener.password=$APEX_LISTENER_PASS" >> $TOMCAT_HOME/webapps/params/ords_params.properties
	echo "user.apex.restpublic.password=$APEX_REST_PASS" >> $TOMCAT_HOME/webapps/params/ords_params.properties
	echo "user.public.password=$ORDS_PASS" >> $TOMCAT_HOME/webapps/params/ords_params.properties
	echo "sys.user=SYS" >> $TOMCAT_HOME/webapps/params/ords_params.properties
	echo "sys.password=$SYS_PASS" >> $TOMCAT_HOME/webapps/params/ords_params.properties

	java -jar $TOMCAT_HOME/webapps/ords.war
fi
exec catalina.sh "$1"
