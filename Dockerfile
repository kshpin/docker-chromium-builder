FROM ubuntu:18.04

ENV PATH="$PATH:/chromium/depot_tools"

RUN useradd -m chromium \
    && mkdir /chromium \
    && chown -R chromium:chromium /chromium

RUN apt update \
    && apt -y install python git lsb-release sudo python-pkg-resources \
    && apt clean \
    && bash <(curl -s "https://chromium.googlesource.com/chromium/src/+/master/build/install-build-deps.sh") \
    && cd /chromium \
    && git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git \
    && gclient runhooks

WORKDIR /chromium
VOLUME /chromium
USER chromium

CMD ["/bin/bash"]
