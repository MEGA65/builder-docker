FROM ubuntu:focal

# install build dependecies
USER root
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Etc/UTC
#RUN sed -i -e 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//http:\/\/de.archive.ubuntu.com\/ubuntu\//' /etc/apt/sources.list \
RUN apt update \
 && apt install -y wget \
 && wget https://cli.github.com/packages/githubcli-archive-keyring.gpg -O /usr/share/keyrings/githubcli-archive-keyring.gpg \
 && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list \
 && apt update \
 && apt install -y build-essential pkg-config git gh wget python3 sshpass unzip imagemagick locales p7zip-full \
                   libusb-1.0-0-dev libgif-dev libpng-dev libgtest-dev libgmock-dev libreadline-dev libtinfo5 \
				   libcairo2-dev gettext-base bsdiff python3-requests python3-paramiko \
 && apt clean -y \
 && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
 && locale-gen \
 && useradd -u 1000 -d /home/mega -s /bin/bash -m mega \
 && mkdir -p /home/mega/.ssh /home/mega/.Xilinx/Vivado /home/mega/assets \
 && chown -R mega:mega /home/mega/.ssh /home/mega/.Xilinx /home/mega/assets \
 && chmod 2700 /home/mega/.ssh

COPY --chown=mega:mega 910828.BIN /home/mega/assets/910828.BIN
COPY --chown=mega:mega Vivado_init.tcl /home/mega/.Xilinx/Vivado/Vivado_init.tcl
COPY filehost-upload /usr/local/bin/filehost-upload

# build and install exomizer
RUN mkdir /tmp/exomizer \
 && cd /tmp/exomizer \
 && wget https://bitbucket.org/magli143/exomizer/wiki/downloads/exomizer-3.1.1.zip \
 && unzip exomizer-3.1.1.zip \
 && cd src \
 && make \
 && cp exomizer /usr/local/bin \
 && cd \
 && rm -rf /tmp/exomizer \
 && chmod 755 /usr/local/bin/exomizer /usr/local/bin/filehost-upload

## build and install cc65 V2.19
RUN cd /tmp \
 && git clone --depth 1 --branch V2.19 https://github.com/cc65/cc65.git \
 && cd cc65 \
 && make PREFIX=/usr -j 8 \
 && make PREFIX=/usr install \
 && cd \
 && rm -rf /tmp/cc65

## build and install mega65-tools needed on server
RUN cd /tmp \
 && git clone --depth 1 https://github.com/MEGA65/mega65-tools.git \
 && cd mega65-tools \
 && make DO_SMU=1 USE_LOCAL_CC65=1 bin/romdiff bin/bit2core bin/bit2mcs \
 && cp bin/romdiff bin/bit2core bin/bit2mcs /usr/local/bin \
 && cd \
 && rm -rf /tmp/mega65-tools \
 && chmod 755 /usr/local/bin/romdiff /usr/local/bin/bit2core /usr/local/bin/bit2mcs

## build and install bsa
RUN cd /tmp \
 && git clone --depth 1 https://github.com/MEGA65/BSA.git \
 && cd BSA \
 && gcc -o /usr/local/bin/bsa bsa.c \
 && cd \
 && rm -rf /tmp/BSA \
 && chmod 755 /usr/local/bin/bsa

USER mega
RUN ssh-keyscan -H t.ktk.de tardis.ktk.de 212.7.186.22 > /home/mega/.ssh/known_hosts \
 && chmod 600 /home/mega/.ssh/known_hosts

USER root

