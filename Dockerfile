FROM ubuntu

ENV \
    DISPLAY=unix:0.0
RUN set -xe &&\
    export DEBIAN_FRONTEND=noninteractive &&\
    apt-get update &&\
    apt-get install --yes \
        libx11-6 \
        libx11-xcb1 \
        libxcb-dri3-0 \
        libxcomposite1 \
        libxcursor1 \
        libxext6 \
        librust-gobject-sys-dev \
        libxi6 \
        libxtst6 \
        libnss3 \
        libatk1.0-0 \
        libatk-bridge2.0-0 \
        librust-gdk-pixbuf-sys-dev \
        libgtk-3-0 \
        libdrm2 \
        libgbm1 \
        libxss1 \
        libasound2 \
        gnupg \
        curl &&\
    curl --silent --output - https://typora.io/linux/public-key.asc | apt-key add - &&\
    echo "deb https://typora.io/linux ./" | tee /etc/apt/sources.list.d/typora.list &&\
    apt-get update &&\
    apt-get install --yes typora &&\
    # Setup enveroument
    echo "NO_AT_BRIDGE=1" | tee -a /etc/environment &&\
    useradd --no-log-init --user-group --home-dir /home creator && \
    # Clean
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps  && \
    apt-get clean  && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

WORKDIR /home

ENTRYPOINT ["entrypoint"]
