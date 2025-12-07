FROM thwint/alpine-base:3.23.0

COPY *.sh /
COPY pdns.conf /etc/pdns/
COPY sql /etc/pdns/sql

RUN apk add --no-cache pdns=5.0.1-r0 pdns-backend-mysql=5.0.1-r0 \
    pdns-backend-sqlite3=5.0.1-r0 pdns-backend-pgsql=5.0.1-r0 \
    pdns-backend-mariadb=5.0.1-r0 mysql-client=11.4.9-r0 && \
    rm -rf /var/cache/apk/*

EXPOSE 53/tcp 53/udp 8081

HEALTHCHECK --interval=1m CMD /healthcheck.sh || exit 1

CMD ["/docker-entrypoint.sh"]
