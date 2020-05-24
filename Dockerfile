FROM alpine:3.8

ENV MNT_POINT /data
ARG S3FS_VERSION=v1.86

RUN apk --update --no-cache add fuse alpine-sdk automake autoconf libxml2-dev fuse-dev curl-dev git bash \
                                ca-certificates \
                                ffmpeg \
                                openssl \
                                python3 \
                                aria2 \
    && pip3 install youtube-dl

RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git; \
    cd s3fs-fuse; \
    git checkout tags/${S3FS_VERSION}; \
    ./autogen.sh; \
    ./configure --prefix=/usr; \
    make; \
    make install; \
    make clean; \
    rm -rf /var/cache/apk/*; \
    apk del git automake autoconf;

RUN mkdir -p "$MNT_POINT"

WORKDIR ${MNT_POINT}

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["bash", "/docker-entrypoint.sh"]