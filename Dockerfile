FROM python:3.8.5-slim

ARG MAKEFLAGS=""

RUN apt update && apt install --no-install-recommends -y \
    git cmake make g++ net-tools wireless-tools iproute2 iw \
    libpcap-dev libev-dev libnl-3-dev libnl-genl-3-dev \
    libnl-route-3-dev \
    zlib1g-dev libjpeg-dev \
    && apt autoremove -y && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install \
    pillow==6.2.2 \
    opendrop \
    && rm -rf /root/.cache/pip /root/.python_history /root/.wget-hsts

RUN git clone --recursive --depth=1 https://github.com/seemoo-lab/owl.git /tmp/owl \
    && mkdir /tmp/owl/build \
    && cd /tmp/owl/build \
    && cmake .. \
    && make \
    && make install \
    && cd /tmp \
    && rm -rf owl

CMD /bin/bash
