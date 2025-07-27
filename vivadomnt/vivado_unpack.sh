#!/bin/bash

cd /

VIVADOPKG=/Vivado-==VER==-installed.tar
VIVADOPATH=/opt/Xilinx/Vivado/==VER==

if [[ -e ${VIVADOPKG}.xz ]]; then
	VIVADOPKG=${VIVADOPKG}.xz
	DECOMPRESS=-J
elif [[ -e ${VIVADOPKG}.gz ]]; then
	VIVADOPKG=${VIVADOPKG}.gz
	DECOMPRESS=-z
else
	echo "Failed to find suitable VIVADOPKG!"
	exit 1
fi

tar -x -v ${DECOMPRESS} --xform 's:^var/opt/:opt/:' -f ${VIVADOPKG}

# fix setting paths from /var/opt to /opt
for file in ${VIVADOPATH}/.setting* ${VIVADOPATH}/setting*; do
	sed -i -e 's:/var/opt/:/opt/:g' ${file}
done

# remove all non-Vivado settings, as we only need Vivado
grep -E "^(|#.+|source .+/.settings64-Vivado.sh)$" ${VIVADOPATH}/settings64.sh > ${VIVADOPATH}/settings64.sh.new
mv ${VIVADOPATH}/settings64.sh.new ${VIVADOPATH}/settings64.sh

# copy custom wrapper
cp /vivado_wrapper.sh /opt/Xilinx/
chmod 755 /opt/Xilinx/vivado_wrapper.sh

