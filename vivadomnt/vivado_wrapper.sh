#!/bin/bash

# Check if VIVADODIR is empty or undefined and detect version instead
if [ -z "$VIVADODIR" ]; then
    VIVADODIR=`ls -1d /opt/Xilinx/Vivado/* | tail -1`
fi

. ${VIVADODIR}/settings64.sh
echo "vivado $*"
LD_PRELOAD=/lib/x86_64-linux-gnu/libudev.so.1 vivado $*
