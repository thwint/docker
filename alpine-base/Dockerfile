FROM alpine:3.22.1

RUN apk add --no-cache tzdata=2025b-r0 curl=8.14.1-r2 openssl=3.3.5-r0 \
    ca-certificates=20250911-r0 && \
    update-ca-certificates && \
    cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime && \
    echo "Europe/Zurich" > /etc/timezone && \
    addgroup -g 1000 basegroup && \
    adduser -u 1000 -G basegroup -D baseuser && \
    rm -f /var/cache/dpk/*
