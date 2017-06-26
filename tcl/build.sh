#!/bin/bash

ARCH_FLAG=""
if [ "${ARCH}" == "64" ]
then
    ARCH_FLAG="--enable-64bit"
fi

ls
cd unix
./configure \
	--prefix="${PREFIX}" \
	$ARCH_FLAG
make -j${CPU_COUNT}
make install

# copy additional headers needed to build tk and similar packages
cp *.h ${PREFIX}/include/
cp ../generic/tcl*.h ${PREFIX}/include/

cd $PREFIX
rm -rf man share

# Link binaries to non-versioned names to make them easier to find and use.
ln -s "${PREFIX}/bin/tclsh8.5" "${PREFIX}/bin/tclsh"
