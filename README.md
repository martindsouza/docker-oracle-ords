# ORDS Dockerfile

Note: This project has leveraged the work of [https://github.com/lucassampsouza/ords_apex](https://github.com/lucassampsouza/ords_apex) and expanded on it so any version of ORDS will work.

The reason why this image is not posted on [Docker Hub](https://hub.docker.com) is due to Oracle requiring that you download and accept their terms and conditions for ORDS.

## Pre-Install

1. Clone this repo: `git clone https://github.com/martindsouza/docker-ords.git`
1. Download [ORDS](http://www.oracle.com/technetwork/developer-tools/rest-data-services/downloads/index.html)
1. Unzip ORDS. ex: `unzip ~/docker/ords/ords.3.0.12.263.15.32.zip ords.war`
1. Copy `ords.war` to `docker-ords` (this cloned repo)

## Build ORDS Docker Image

Note: tagging with ORDS version number so you can have multiple ORDS images for each ORDS release.
```bash
ORDS_VERSION=3.0.12
docker build -t ords:$ORDS_VERSION .
```

## Create Container

```bash
#Note: DB_PORT is NOT the port that you mapped to your Oracle DB Docker image. It's the port that the database natively has open.
# It's recommended to leave it as 1521
# Optional: If DB is in another Docker machine include: --network=<docker_network_name> \
docker run -t -i \
  --name ords:3.0.12 \
  -e DB_HOSTNAME=oracle \
  -e DB_PORT=1521 \
  -e DB_SERVICENAME=ORCLPDB1 \
  -e APEX_PUBLIC_USER_PASS=oracle \
  -e APEX_LISTENER_PASS=oracle \
  -e APEX_REST_PASS=oracle \
  -e ORDS_PASS=oracle \
  -e SYS_PASS=Oradoc_db1 \
  --volume /Users/giffy/docker/apex/5.1.3/images:/usr/local/tomcat/webapps/i \
  -p 8080:8080 \
  ords
```

On your laptop go to [localhost:8080/ords](http://localhost:8080/ords) to run

### Parameters
Parameter | Description
--- | ---
`-e DB_HOSTNAME` | Hostname of Oracle DB
`-e DB_PORT` | TNS port to DB. Note: If on a Docker Network don't use the mapped port. Most likely this will always be `1521`
`-e DB_SERVICENAME` | DB servicename
`-e APEX_PUBLIC_USER_PASS` | `APEX_PUBLIC_USER` password (to be created)
`-e APEX_LISTENER_PASS` | `APEX_LISTENER` password (to be created)
`-e APEX_REST_PASS` | `APEX_REST` password (to be created)
`-e ORDS_PASS` | `ORDS_PUBLIC_USER` password (to be created)
`-e SYS_PASS` | `SYS` password
`--volume <local dir>:/usr/local/tomcat/webapps/i`  |  Directory that contains images for APEX
`-p 1234:8080`  |  Port mapping
