FROM sagebind/base:latest
MAINTAINER Stephen Coakley <me@stephencoakley.com>

RUN apk --no-cache add bind-tools curl jq

COPY ddns.sh /etc/periodic/hourly/ddns
