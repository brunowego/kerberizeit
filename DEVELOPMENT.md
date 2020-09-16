# Development

```sh
docker network create workbench \
  --subnet 10.1.1.0/24
```

```sh
# Darwin
./kerberizeit.sh

# Ubuntu
docker run -i --rm \
  $(echo "$DOCKER_RUN_OPTS") \
  -h ubuntu \
  --name ubuntu \
  -v "$PWD"/kerberizeit.sh:/kerberizeit.sh \
  --network workbench \
  docker.io/library/ubuntu:18.04 /bin/bash -c /kerberizeit.sh

# CentOS
docker run -i --rm \
  $(echo "$DOCKER_RUN_OPTS") \
  -h centos \
  --name centos \
  -v "$PWD"/kerberizeit.sh:/kerberizeit.sh \
  --network workbench \
  docker.io/library/centos:7.6.1810 /bin/bash -c /kerberizeit.sh

# Alpine
docker run -i --rm \
  $(echo "$DOCKER_RUN_OPTS") \
  -h alpine \
  --name alpine \
  -v "$PWD"/kerberizeit.sh:/kerberizeit.sh \
  --network workbench \
  docker.io/library/alpine:3.9 /bin/sh << EOSHELL
apk add bash
/bin/bash -c /kerberizeit.sh
EOSHELL
```
