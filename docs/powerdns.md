# Powerdns Docker image

![Github workflow](https://github.com/thwint/docker/actions/workflows/powerdns.yml/badge.svg)
![Known Vulnerabilities](https://snyk.io/test/github/{username}/{repo}/badge.svg)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/thwint/powerdns)
![Docker Image Version (latest by date)](https://img.shields.io/docker/v/thwint/powerdns)
![License GPL](https://img.shields.io/badge/license-GPL-blue.svg)

A docker container shipping PowerDNS nameserver

## Image details

### Packages

* pdns
* pdns-backend-mysql
* pdns-backend-sqlite3
* pdns-backend-pgsql
* pdns-backend-mariadb
* mysql-client

## Run

### docker-compose

PowerDNS server with webserver and API enabled.

```yaml
version: '2.1'
services:
  pdns:
    image: pdns
    container_name: quay.io/thwint/powerdns
    hostname: pdns
    environment:
      PDNS_LAUNCH: gmysql
      PDNS_GMYSQL_HOST: pdns.db
      PDNS_GMYSQL_PORT: 3306
      PDNS_GMYSQL_DBNAME: pdns
      PDNS_GMYSQL_USER: pdns
      PDNS_GMYSQL_PASSWORD: pdnspassword
      PDNS_WEBSERVER: "yes"
      PDNS_WEBSERVER_ADDRESS: 0.0.0.0
      PDNS_WEBSERVER_PORT: 8081
      PDNS_WEBSERVER_PASSWORD: webpassword
      PDNS_WEBSERVER_ALLOW_FROM: "172.19.0.0/16"
      PDNS_API: "yes"
      PDNS_API_KEY: mysecretapikey
      PDNS_ALLOW_AXFR_IPS: "123.45.6.7,123.54.7.6"
      PDNS_LOCAL_ADDRESS: 0.0.0.0
    ports:
      - "53:53"
    depends_on:
      - "pdns.db"
    networks:
      - default

  pdns.db:
    image: mariadb
    container_name: pdns.db
    hostname: pdns.db
    environment:
      MYSQL_ROOT_PASSWORD: dbadminpassword
      MYSQL_DATABASE: pdns
      MYSQL_USER: pdns
      MYSQL_PASSWORD: pdnspassword
    networks:
      - default
```

## Configuration

The powerdns server can be configured using environment variables. See
<https://doc.powerdns.com/authoritative/settings.html#> for further information.

All variables beginning with PDNS will be translated into a powerdns setting
variable and included in pdns.conf.

Example:

`PDNS_GMYSQL_HOST` will become `gmysql-host` in pdns.conf.

For docker swarm it is also possible possible to configure some sensitive data
from secret files. For that purpose add _FILE to the existing environment
variable. The following secrets can be configured using secrets:

* PDNS_GMYSQL_PASSWORD_FILE
* PDNS_WEBSERVER_PASSWORD_FILE
* PDNS_API_KEY_FILE
