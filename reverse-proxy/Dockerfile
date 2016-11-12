FROM sagebind/nginx:latest
MAINTAINER Stephen Coakley <me@stephencoakley.com>

RUN apk --no-cache add dnsmasq && \
    rm /etc/nginx/conf.d/default.conf

COPY root /
