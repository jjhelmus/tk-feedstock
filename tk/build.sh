#!/bin/bash

ARCH_FLAG=""
if [ "${ARCH}" == "64" ]
then
    ARCH_FLAG="--enable-64bit"
fi

export CFLAGS="-I$PREFIX/include $CFLAGS"
export LDFLAGS="-L$PREFIX/lib -Wl,-rpath=$PREFIX/lib,--no-as-needed"
cd unix
./configure \
	--prefix="${PREFIX}" \
	$ARCH_FLAG \
	--enable-aqua=yes
make -j${CPU_COUNT}
make install

cd $PREFIX
rm -rf man share

# Link binaries to non-versioned names to make them easier to find and use.
ln -s "${PREFIX}/bin/wish8.5" "${PREFIX}/bin/wish"
