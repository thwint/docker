# Chromium browser

![Github workflow](https://github.com/thwint/docker/actions/workflows/chromium.yml/badge.svg)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/thwint/chromium-browser)
![Docker Image Version (latest by date)](https://img.shields.io/docker/v/thwint/chromium-browser)
![License GPL](https://img.shields.io/badge/license-GPL-blue.svg)

This docker image runs a chromium browser accessible using vnc.

## Image details

The container starts a X server, a vnc server and opens the configured web site
using chromium.

The running browser is accessible using vnc.

### Packages

* bash
* chromium
* x11vnc
* xdpyinfo
* xvfb

## Run

After starting the container connect your favorite vnc client to the exposed
port (`5900`). The default password is set to `passwd`

### docker

```bash
docker run --rm --name chromium -p 5900:5900 thwint/chromium-browser:latest
```

### docker compose

```yaml
version: '2.1'
services:
  chromium:
    image: thwint/chromium-browser
    container_name: chromium
    restart: always
    hostname: chromium
    environment:
      BROWSER_URL: your.fancy.website.com
    ports:
      - 5900:5900
```

## Configuration

### VNC password

By default the VNC password is set to `passwd`. To override this password you
can set the `PASSWD_FILE` environment variable and map the file into the container.

Create a new password using `echo "newpasswd" >> passwdfile` and run the
container again:

```bash
docker run --rm --name chromium -p 5900:5900 \
-v ./passwdfile:/config/passwdfile \
-e PASSWD_FILE=/config/passwdfile
thwint/chromium-browser:latest
```

### CHROMIUM_FLAGS

The chromium flags in this image are very specific for a test case. If you need
another set of flags you can create your own file and replace the existing file
in `/etc/chromium/chromium.conf`.

Current defaults:

```shell
CHROMIUM_FLAGS="--disable-gpu --disable-software-rasterizer \
--disable-dev-shm-usage --kiosk --touch-events=enabled \
--no-sandbox --disable-features=TranslateUI"
```

### Environment variables

| Variable name | default value              | description                                   |
| ------------- | -------------------------- | --------------------------------------------- |
| BROWSER_URL   |                            | The url to be opened when the browser starts. |
| PASSWD_FILE   | /home/baseuser/.vnc/passwd | The file containing the vnc password          |
| RESOLUTION    | 1024x768x24                | The resolution used for Xvfb                  |

There is no default startup url defined. But you can add an environment
variable containing the desired startup url.
