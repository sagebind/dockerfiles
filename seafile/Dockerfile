FROM sagebind/nginx

# Install runtime dependencies.
RUN apk --no-cache add bash ca-certificates curl glib jansson libarchive libevent libuuid openssl python py2-pip \
    py-chardet py-dateutil py-flup py-gevent py-gunicorn py-imaging py-numpy py-pyldap py-requests py-tz \
    sqlite util-linux

ENV SERVER_NAME=seafile \
    FILESERVER_PORT=8082 \
    CCNET_PORT=10001 \
    SEAFILE_PORT=12001 \
    CCNET_CONF_DIR=/srv/ccnet \
    SEAFILE_CENTRAL_CONF_DIR=/srv/conf \
    SEAFILE_CONF_DIR=/data \
    SEAHUB_LOG_DIR=/srv/logs \
    PYTHONPATH=/srv/seafile-server/seahub:/srv/seafile-server/seahub/thirdpart:/usr/local/lib/python2.7/site-packages

ARG SEAFILE_VERSION=6.2.3
RUN apk --no-cache add --virtual .build autoconf automake bsd-compat-headers build-base cmake curl-dev fuse-dev \
    glib-dev intltool jansson-dev jpeg-dev libarchive-dev libevent-dev libpng-dev libtool musl-dev openssl-dev \
    python-dev sqlite-dev util-linux-dev vala zlib-dev && \

    # Download Seafile source bundles and dependencies
    mkdir /src && cd /src && \
    curl -L https://github.com/criticalstack/libevhtp/archive/1.1.6.tar.gz | tar xzf - && \
    curl -L https://github.com/haiwen/libsearpc/archive/v3.1-latest.tar.gz | tar xzf - && \
    curl -L https://github.com/haiwen/seafile-server/archive/v${SEAFILE_VERSION}-server.tar.gz | tar xzf - && \
    curl -L https://github.com/haiwen/ccnet-server/archive/v${SEAFILE_VERSION}-server.tar.gz | tar xzf - && \
    curl -L https://github.com/haiwen/seahub/archive/v${SEAFILE_VERSION}-server.tar.gz | tar xzf - && \

    # Compile and install libevhtp
    cd /src/libevhtp-1.1.6 && \
    cmake -DEVHTP_DISABLE_SSL=ON -DEVHTP_BUILD_SHARED=OFF . && \
    make install && \

    # Compile and install libsearpc
    cd /src/libsearpc-3.1-latest && \
    ./autogen.sh && \
    ./configure && \
    make install && \

    # Compile and install ccnet
    cd /src/ccnet-server-${SEAFILE_VERSION}-server && \
    ./autogen.sh && \
    ./configure --without-mysql --without-postgresql && \
    make install && \

    # Compile and install seafile
    cd /src/seafile-server-${SEAFILE_VERSION}-server && \
    export CFLAGS="-I/usr/include/evhtp" && \
    ./autogen.sh && \
    ./configure && \
    make install && \
    mkdir -p /srv && mv scripts /srv/scripts && \

    # Install seahub
    mkdir -p /srv/seafile-server && mv /src/seahub-${SEAFILE_VERSION}-server /srv/seafile-server/seahub && \
    cd /srv/seafile-server/seahub && \
    pip install https://github.com/haiwen/django-constance/archive/6b04a31.zip && \
    env LIBRARY_PATH=/lib:/usr/lib pip install -r requirements.txt && \

    # Cleanup
    cd / && rm -rf /src /root/.cache && \
    apk --no-cache del .build

COPY etc /etc
COPY seahub.conf /srv/seafile-server/runtime/seahub.conf

WORKDIR /srv
VOLUME $SEAFILE_CONF_DIR

EXPOSE 80 $FILESERVER_PORT $CCNET_PORT $SEAFILE_PORT
