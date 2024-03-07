FROM megabuild

# install build dependecies
USER root
RUN apt update \
 && apt install -y gcc-mingw-w64 mingw-w64-common libz-mingw-w64-dev python3-pip cmake \
 && pip3 install conan \
 && apt clean -y

USER mega
COPY conanfile.txt /home/mega/conanfile.txt
COPY conan_profile_docker_to_win /home/mega/conan_profile_docker_to_win
RUN cd /home/mega \
 && mkdir -p pc/win \
 && echo "{% set toolchain = \"/usr/x86_64-w64-mingw32\" %}" > profile_mingw-w64 \
 && echo "{% set cc_version = \"`x86_64-w64-mingw32-gcc -dumpversion | sed 's/^\([[:digit:]]\+\(\.[[:digit:]]\+\)\?\).*$/\1/'`\" %}" >> profile_mingw-w64 \
 && conan profile detect \
 && conan install -of pc/win conanfile.txt --build=missing -pr:h=conan_profile_docker_to_win

USER root
