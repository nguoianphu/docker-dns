# Dockerfile for ISC BIND DNS servers

# Build with:
# docker build -t "dns" .

# Run with:
# docker run -d -p 53:53 --name my-dns dns

# Alpine OS 3.4
# http://dl-cdn.alpinelinux.org/alpine/v3.4/community/x86_64/
FROM alpine:3.4

MAINTAINER Tuan Vo <vohungtuan@gmail.com>


####################################################
########               GCC               ###########
####################################################
# The GNU Compiler Collection 5.3.0-r0

RUN set -x \
    && apk add --no-cache \
        bash \
        gcc \
        # build-essential \
        # alpine-sdk \
    && rm -rf /var/cache/apk/*

###############################################################################
#                                INSTALLATION
###############################################################################


####################################################
#########              GoSU              ###########
####################################################

### install gosu for easy step-down from root
### https://github.com/tianon/gosu/releases

ENV GOSU_VERSION 1.9

RUN set -x \
    && apk add --no-cache --virtual .gosu-deps \
        dpkg \
        gnupg \
        openssl \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apk del .gosu-deps \
    && rm -rf /var/cache/apk/*


####################################################
#########              BIND              ###########
####################################################

ENV BIND_VERSION 9-11-0

ENV BUILD_OPTIONS "--with-openssl= "

# ENV OPEN_SSL 9.11.0
# ENV KERBEROS 9.11.0
# ENV LIBXML 9.11.0

ENV BIND_DIR /opt/bind

RUN set -x \
 && addgroup bind \
 && adduser -D -S bind -s /bin/bash -h ${BIND_DIR} -g "BIND service user" -G bind \
 && mkdir -p ${BIND_DIR} \
 && curl -L -O https://www.isc.org/downloads/file/bind-${BIND_VERSION}/?version=tar-gz
 && tar xzf bind-${BIND_VERSION}.tar.gz  -C ${BIND_DIR} --strip-components=1 \
 && rm -rf bind-${BIND_VERSION}.tar.gz \
 && chown -R elk:elk ${BIND_DIR} \
 && ${BIND_DIR}/configure \
 && make clean \
 && make \
 && make test \
 && make install

# BIND is at /usr/local/

###############################################################################
#                                   START
###############################################################################

ENV PATH ${ES_HOME}/bin:$PATH


# 53 DNS port
EXPOSE 53

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
 
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [""]
