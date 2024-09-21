FROM ubuntu:22.04

COPY ODIN_* /tmp/
RUN apt-get update && \
    apt-get install -y llvm clang git build-essential && \
    mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/odin-lang/Odin.git -b dev-$(cat /tmp/ODIN_VERSION) odin-install && \
    cd odin-install && \
    make && \
    mkdir -p /opt/odin && \
    cp -r ./base ./core ./shared ./vendor ./odin /opt/odin/ && \
    cd / && \
    rm -rf /opt/odin-install && \
    apt-get remove -y git && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/*
ENV PATH="${PATH}:/opt/odin"
