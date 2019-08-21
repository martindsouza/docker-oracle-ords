#!/bin/ash

# Add curl for Healthcheck
apk add --no-cache curl

# Make Params and apex-images folder
mkdir $ORDS_DIR/params
# Don't need to create this dir since it's mounted as a volume
# mkdir $ORDS_DIR/apex-images

# Move ORDS files
mv /tmp/config-run-ords.sh $ORDS_DIR/

# This is legacy mv command. ords.war will already be in $ORDS_DIR
# mv /tmp/ords.war $ORDS_DIR/

# Set ORDS config dir
chmod +x $ORDS_DIR/config-run-ords.sh && \
java -jar ords.war configdir $APEX_CONFIG_DIR
