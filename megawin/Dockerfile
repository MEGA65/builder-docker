FROM megabuild

# install build dependecies
USER root
RUN apt install -y gcc-mingw-w64 mingw-w64-common libz-mingw-w64-dev python3-pip cmake \
 && pip3 install conan \
 && apt clean -y

USER mega
COPY conanfile.txt /home/mega/conanfile.txt
COPY conan_profile_docker_to_win /home/mega/conan_profile_docker_to_win
RUN cd /home/mega \
 && echo "toolchain=/usr/x86_64-w64-mingw32" > profile_mingw-w64 \
 && echo "cc_version=`x86_64-w64-mingw32-gcc -dumpversion | sed 's/-win32//g'`" >> profile_mingw-w64 \
 && conan install conanfile.txt --build=missing -pr:b=default -pr:h=default -pr:h=conan_profile_docker_to_win

USER root
