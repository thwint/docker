FROM thwint/alpine-base:3.20

COPY *.sh /
COPY pdns.conf /etc/pdns/
COPY sql /etc/pdns/sql

RUN apk add --no-cache pdns=4.9.1-r0 pdns-backend-mysql=4.9.1-r0 pdns-backend-sqlite3=4.9.1-r0 pdns-backend-pgsql=4.9.1-r0 pdns-backend-mariadb=4.9.1-r0 mysql-client=10.11.8-r0 && \
    rm -rf /var/cache/apk/*

EXPOSE 53/tcp 53/udp 8081

HEALTHCHECK --interval=1m CMD /healthcheck.sh || exit 1

CMD ["/docker-entrypoint.sh"]
