FROM ubuntu:18.04

ENV PATH="$PATH:/chromium/depot_tools"

RUN useradd -m chromium \
    && mkdir /chromium \
    && chown -R chromium:chromium /chromium
    
RUN apt update \
    && apt-get -y install python git curl lsb-release sudo python-pkg-resources locales \
    && apt-get clean

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles
RUN apt-get -y install tzdata

RUN locale-gen "en_US.UTF-8" \
    && dpkg-reconfigure locales

RUN curl -s https://raw.githubusercontent.com/chromium/chromium/master/build/install-build-deps.sh --output /tmp/install-build-deps.sh \
    && chmod +x /tmp/install-build-deps.sh \
    && /tmp/install-build-deps.sh --no-chromeos-fonts

WORKDIR /chromium
VOLUME /chromium
USER chromium

CMD ["/bin/bash"]
