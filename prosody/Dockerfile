FROM sagebind/nginx

ARG PROSODY_NIGHTLY=1nightly435
ENV HOST=localhost

# Install Prosody server.
RUN apk --no-cache add ca-certificates curl libevent libidn lua5.1-dbi-sqlite3 lua5.1-expat lua5.1-filesystem \
    lua5.1-libs lua5.1-sec openssl && \

    # Build time dependencies.
    apk --no-cache add --virtual .build build-base git libevent-dev libidn-dev linux-headers lua5.1-dev luarocks5.1 \
    openssl-dev && \

    # Build Prosody nightly.
    curl https://prosody.im/nightly/0.10/build435/prosody-0.10-${PROSODY_NIGHTLY}.tar.gz | tar xzf - && \
    cd prosody-0.10-${PROSODY_NIGHTLY} && \
    ./configure \
        --ostype=linux \
        --prefix=/usr \
        --sysconfdir=/etc/prosody  \
        --with-lua=/usr  \
        --with-lua-lib=/usr/lib \
        --with-lua-include=/usr/include \
        --add-cflags="-DWITHOUT_MALLINFO" \
        --no-example-certs && \
    make install && \
    addgroup -S prosody && \
    adduser -S -D -h /var/lib/prosody -s /sbin/nologin -G prosody -g "Prosody XMPP Server" prosody && \

    # Build other required Lua native modules.
    luarocks-5.1 install luabitop && \
    luarocks-5.1 install luaevent && \

    # Cleanup
    cd .. && \
    rm -rf prosody-0.10-${PROSODY_NIGHTLY} && \
    apk --no-cache del .build

# Install community modules.
RUN curl https://hg.prosody.im/prosody-modules/archive/tip.tar.gz | tar xzf - && \
    cd prosody-modules-* && \
    mkdir -p /srv/prosody/modules && \
    cp mod_admin_message/*.lua /srv/prosody/modules && \
    cp mod_csi/*.lua /srv/prosody/modules && \
    cp mod_filter_chatstates/*.lua /srv/prosody/modules && \
    cp mod_smacks/*.lua /srv/prosody/modules && \
    cp mod_throttle_presence/*.lua /srv/prosody/modules && \
    cd .. && rm -r prosody-modules-*

# Install web frontend.
RUN curl -L -o inverse.min.js https://github.com/jcbrand/converse.js/releases/download/v3.2.1/inverse.min.js && \
    curl -L https://github.com/jcbrand/converse.js/archive/v3.2.1.tar.gz | tar xzf - && \
    mv converse.js-3.2.1/css/inverse.css ./ && \
    rm -r converse.js-3.2.1

COPY etc /etc
COPY www /srv/www

VOLUME /etc/certs /data

EXPOSE 5222 5269
