# Implementation notes

## megabuild

- github cli for editing releases
- user mega required by tex and vivado
- basic compilers and compilation tools
- utilities like ImageMagick and exomizer

## megawin

- adds gcc-mingw-w64 for windows compilation
- libusb-mingw libs by gurce

## megatex

- adds texlive with custom modules installed as user mega

## Vivado

- used local tar for faster docker setup
  - local tar needs to be a full Vivado install to /opt/Xilinx with full paths
- https://stackoverflow.com/questions/55733058/vivado-synthesis-hangs-in-docker-container-spawned-by-jenkins
  - added --init as docker arg to .jenkinsfile
- https://support.xilinx.com/s/question/0D54U00005Sgst2SAB/failed-batch-mode-execution-in-linux-docker-running-under-windows-host?language=en_US
  - added custom vivado_wrapper.sh to /home/mega which does the LD_PRELOAD

