FROM ubuntu:focal

# install build dependecies
USER root
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Etc/UTC
RUN apt update \
 && apt install -y wget \
 && wget https://cli.github.com/packages/githubcli-archive-keyring.gpg -O /usr/share/keyrings/githubcli-archive-keyring.gpg \
 && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list \
 && apt update \
 && apt install -y build-essential pkg-config git gh wget python3 cc65 sshpass unzip imagemagick locales p7zip-full \
                   libusb-1.0-0-dev libgif-dev libpng-dev libgtest-dev libgmock-dev libreadline-dev libtinfo5 \
				   libcairo2-dev \
 && apt clean -y \
 && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
 && locale-gen \
 && useradd -u 1000 -d /home/mega -s /bin/bash -m mega \
 && mkdir -p /home/mega/.Xilinx/Vivado/2022.2 \
 && chown -R mega:mega /home/mega/.Xilinx

COPY --chown=mega:mega Vivado_init.tcl /home/mega/.Xilinx/Vivado/2022.2/Vivado_init.tcl

# build and install exomizer
RUN mkdir /tmp/exomizer \
 && cd /tmp/exomizer \
 && wget https://bitbucket.org/magli143/exomizer/wiki/downloads/exomizer-3.1.1.zip \
 && unzip exomizer-3.1.1.zip \
 && cd src \
 && make \
 && cp exomizer /usr/local/bin \
 && chmod 755 /usr/local/bin/exomizer

