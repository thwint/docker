FROM alpine:3.23

RUN apk add --no-cache tzdata=2025b-r0 curl=8.17.0-r1 openssl=3.5.4-r0 \
    ca-certificates=20251003-r0 && \
    update-ca-certificates && \
    cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime && \
    echo "Europe/Zurich" > /etc/timezone && \
    addgroup -g 1000 basegroup && \
    adduser -u 1000 -G basegroup -D baseuser && \
    rm -f /var/cache/dpk/*
