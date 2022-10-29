FROM megabuild

# install build dependecies
USER root
RUN apt install -y gcc-mingw-w64 mingw-w64-common libz-mingw-w64-dev \
 && wget gurce.net/ubuntu/pool/main/libp/libpng-mingw-w64/libpng-mingw-w64_1.6.37-1_amd64.deb \
 && dpkg -i libpng-mingw-w64_1.6.37-1_amd64.deb \
 && wget http://gurce.net/ubuntu/libusb-mingw-w64_1.0.24-1_amd64.deb \
 && dpkg -i libusb-mingw-w64_1.0.24-1_amd64.deb \
 && apt clean -y

