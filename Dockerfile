FROM ubuntu:18.04

ENV PATH="$PATH:/chromium/depot_tools"

RUN useradd -m chromium \
    && mkdir /chromium \
    && chown -R chromium:chromium /chromium

RUN locale-gen "en_US.UTF-8" \
    && dpkg-reconfigure locales

RUN apt update \
    && apt-get -y install python git curl lsb-release sudo python-pkg-resources \
    && apt-get clean \
    #&& /bin/bash -s <(curl -s https://raw.githubusercontent.com/chromium/chromium/master/build/install-build-deps.sh) <(echo -e "12\n10") \
    && curl -s https://raw.githubusercontent.com/chromium/chromium/master/build/install-build-deps.sh | /bin/bash -s \
    && cd /chromium \
    && git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git \
    && gclient runhooks

WORKDIR /chromium
VOLUME /chromium
USER chromium

CMD ["/bin/bash"]
