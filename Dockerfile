FROM ubuntu:18.04

ENV PATH="$PATH:/chromium/depot_tools"

RUN useradd -m chromium \
    && mkdir /chromium \
    && chown -R chromium:chromium /chromium

RUN apt update \
    && apt -y install python git lsb-release sudo python-pkg-resources \
    && apt-get clean

WORKDIR /chromium
VOLUME /chromium
USER chromium

CMD ["/bin/bash"]
