FROM alpine:3.24

RUN apk add --no-cache tzdata=2026e-r0 curl=8.23.0-r0 openssl=3.5.9-r0 \
    ca-certificates=20261020-r0 && \
    update-ca-certificates && \
    cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime && \
    echo "Europe/Zurich" > /etc/timezone && \
    addgroup -g 1000 basegroup && \
    adduser -u 1000 -G basegroup -D baseuser && \
    rm -f /var/cache/dpk/*
