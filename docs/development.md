# ORDS Development Helper

<!-- TOC depthFrom:2 insertAnchor:false -->

- [`docker exec`](#docker-exec)
- [Test Building](#test-building)

<!-- /TOC -->


## `docker exec`

If you need to login to the machine at any point run the following (where `ords` is the name of the container or use the container's hash).

```bash
docker exec -it ords /bin/ash
```

## Test Building

The following bash `alias` will build and run the docker image/container:

```bash
alias dockertest="

ORDS_VERSION=18.1.1
docker build -t ords:$ORDS_VERSION .

docker run -it --rm \
  --network=oracle_network \
  --name=ords \
  -e TZ=America/Edmonton \
  -e DB_HOSTNAME=oracle \
  -e DB_PORT=1521 \
  -e DB_SERVICENAME=orclpdb513.localdomain \
  -e APEX_PUBLIC_USER_PASS=oracle \
  -e APEX_LISTENER_PASS=oracle \
  -e APEX_REST_PASS=oracle \
  -e ORDS_PASS=oracle \
  -e SYS_PASS=Oradoc_db1 \
  --volume ~/Docker/ords/ords-18.1.1/config:/opt/ords \
  --volume ~/docker/apex/5.1.3/images:/ords/apex-images \
  -p 32513:8080 \
  ords:18.1.1"

  dockertest
  ```