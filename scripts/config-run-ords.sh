#!/bin/sh

# Important that script starts with #!/bin/sh and not #!/bin/bash (see https://stackoverflow.com/questions/44803982/how-to-run-a-bash-script-in-an-alpine-docker-container)
PARAM_FILE=$ORDS_DIR/params/ords_params.properties
# The prescence of this file will determine if we install or just run ORDS
ORDS_CONFIG_FILE="/opt/ords/defaults.xml"

cd $ORDS_DIR
	
# if [ -d "$file" ]
if [ -f "$ORDS_CONFIG_FILE" ]
then
	echo "$ORDS_CONFIG_FILE found. Running standalone"
	java -jar ords.war standalone
else
	echo "$ORDS_CONFIG_FILE not found. Installing ORDS"
	echo "Generating ords_params.properties"

	# Clear file
	> $PARAM_FILE 

	# db
	echo "db.hostname=$DB_HOSTNAME" >> $PARAM_FILE
	echo "db.password=$APEX_PUBLIC_USER_PASS" >> $PARAM_FILE
	echo "db.port=$DB_PORT" >> $PARAM_FILE
	echo "db.servicename=$DB_SERVICENAME" >> $PARAM_FILE
	# SID doesnt work so use SERVICENAME instead
	# echo "db.sid=$DB_SID" >> $PARAM_FILE
	echo "db.username=$APEX_PUBLIC_USER_NAME" >> $PARAM_FILE

	# other
	echo "plsql.gateway.add=true" >> $PARAM_FILE

	# rest
	echo "rest.services.apex.add=$REST_SERVICES_APEX" >> $PARAM_FILE
	echo "rest.services.ords.add=$REST_SERVICES_ORDS" >> $PARAM_FILE
	# echo "migrate.apex.rest=$MIGRATE_APEX_REST" >> $PARAM_FILE

	# SQL Dev Web and REST SQL
	echo "restEnabledSql.active=$REST_SQL" >> $PARAM_FILE
	echo "feature.sdw=$FEATURE_SDW" >> $PARAM_FILE

	# schema
	echo "schema.tablespace.default=SYSAUX" >> $PARAM_FILE
	echo "schema.tablespace.temp=TEMP" >> $PARAM_FILE

	# standalone
	echo "standalone.http.port=8080" >> $PARAM_FILE
	echo "standalone.mode=true" >> $PARAM_FILE
	echo "standalone.static.images=/ords/apex-images" >> $PARAM_FILE
	# TODO change make this optional and apply cert options
	echo "standalone.use.https=false" >> $PARAM_FILE

	# user
	echo "user.apex.listener.password=$APEX_LISTENER_PASS" >> $PARAM_FILE
	echo "user.apex.restpublic.password=$APEX_REST_PASS" >> $PARAM_FILE
	echo "user.public.password=$ORDS_PASS" >> $PARAM_FILE
	echo "user.tablespace.default=SYSAUX" >> $PARAM_FILE
	echo "user.tablespace.temp=TEMP" >> $PARAM_FILE

	# sys
	echo "sys.user=SYS" >> $PARAM_FILE
	echo "sys.password=$SYS_PASS" >> $PARAM_FILE

	echo "*** PARAMFILE: $PARAM_FILE"
	# echo "*** PARAMFILE START ***"
	# cat $PARAM_FILE
	# echo "*** PARAMFILE END ***"

	java -jar ords.war install simple --parameterFile $PARAM_FILE
fi


