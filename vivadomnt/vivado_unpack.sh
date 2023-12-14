#!/bin/bash
cd /
tar xvzf /Vivado-==VER==-installed.tar.gz
grep -E "^(|#.+|source .+/.settings64-Vivado.sh)$" /opt/Xilinx/Vivado/2023.2/settings64.sh > /opt/Xilinx/Vivado/2023.2/settings64.sh.new
mv /opt/Xilinx/Vivado/2023.2/settings64.sh.new /opt/Xilinx/Vivado/2023.2/settings64.sh
cp /vivado_wrapper.sh /opt/Xilinx/
chmod 755 /opt/Xilinx/vivado_wrapper.sh
