FROM ubuntu:16.04

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

RUN apt-get -y update && apt-get install -y \
    fuse \
    libfuse2 \
    unzip \
    && apt-get install -y --reinstall ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ADD http://downloads.rclone.org/rclone-current-linux-amd64.zip /tmp/
RUN cd /tmp && \
    unzip rclone-current-linux-amd64.zip && \
    cd rclone-*-linux-amd64 && \
    cp rclone /usr/sbin && \
    chown root:root /usr/sbin/rclone && \
    chmod 755 /usr/sbin/rclone

ENTRYPOINT ["/init", "/usr/sbin/rclone", "--config", "/config/.rclone.conf"]
CMD ["version"]
