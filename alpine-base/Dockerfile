FROM alpine:3.20

RUN apk add --no-cache tzdata=2024a-r1 curl=8.8.0-r0 openssl=3.3.1-r1 \
    ca-certificates=20240226-r0 && \
    update-ca-certificates && \
    cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime && \
    echo "Europe/Zurich" > /etc/timezone && \
    addgroup -g 1000 basegroup && \
    adduser -u 1000 -G basegroup -D baseuser && \
    rm -f /var/cache/dpk/*
