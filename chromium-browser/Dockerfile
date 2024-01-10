FROM thwint/alpine-base:3.19.1

COPY *.sh /

ARG CHROMIUM_VERSION
RUN apk add --no-cache bash=5.2.21-r0 xvfb=21.1.10-r0 xdpyinfo=1.3.4-r1 \
    x11vnc=0.9.16-r5 chromium=${CHROMIUM_VERSION} && \
    echo 'CHROMIUM_FLAGS="--disable-gpu --disable-software-rasterizer --disable-dev-shm-usage --kiosk --touch-events=enabled --no-sandbox --disable-features=TranslateUI"' >> /etc/chromium/chromium.conf && \
    rm -f /var/cache/apk/*

USER baseuser

RUN mkdir -p ~/.vnc/ && \
    echo "passwd" >> ~/.vnc/passwd

ENV DISPLAY=:42

ENTRYPOINT ["/docker-entrypoint.sh"]
HEALTHCHECK --interval=1m CMD /healthcheck.sh || exit 1

EXPOSE 5900
