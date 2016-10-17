FROM alpine:3.4
MAINTAINER Stephen Coakley <me@stephencoakley.com>

RUN apk --no-cache add s6

COPY root/ /

ENTRYPOINT ["/sbin/init"]
