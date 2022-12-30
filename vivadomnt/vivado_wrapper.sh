#!/bin/bash

VIVADODIR=/opt/Xilinx/Vivado/==VER==

. ${VIVADODIR}/settings64.sh
echo "vivado $*"
LD_PRELOAD=/lib/x86_64-linux-gnu/libudev.so.1 vivado $*
