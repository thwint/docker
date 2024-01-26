FROM thwint/alpine-base:3.19.3

COPY *.sh /
COPY pdns.conf /etc/pdns/
COPY sql /etc/pdns/sql

RUN apk add --no-cache pdns=4.8.3-r2 pdns-backend-mysql=4.8.3-r2 pdns-backend-sqlite3=4.8.3-r2 pdns-backend-pgsql=4.8.3-r2 pdns-backend-mariadb=4.8.3-r2 mysql-client=10.11.6-r0 && \
    rm -rf /var/cache/apk/*

EXPOSE 53/tcp 53/udp 8081

HEALTHCHECK --interval=1m CMD /healthcheck.sh || exit 1

CMD ["/docker-entrypoint.sh"]
