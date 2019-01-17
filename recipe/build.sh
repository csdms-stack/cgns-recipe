#! /usr/bin/env bash

_libpath=/usr/lib
case `uname -s` in
    Linux)
	_libpath=$BUILD_PREFIX/$HOST/sysroot/usr/lib
	;;
    Darwin)
	export MACOSX_DEPLOYMENT_TARGET=""
	;;
    *)
	echo "Unknown OS"
	exit 1
esac
export _libpath

mkdir _build && cd _build
cmake .. \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DCGNS_BUILD_SHARED=ON \
    -DCGNS_USE_SHARED=ON \
    -DCGNS_ENABLE_FORTRAN=ON \
    -DCGNS_ENABLE_HDF5=ON \
    -DCGNS_ENABLE_TESTS=ON \
    -DCGNS_ENABLE_LFS=ON \
    -DCMAKE_C_FLAGS:STRING=-D_LARGEFILE64_SOURCE \
    -DHDF5_NEED_SZIP=OFF \
    -DHDF5_NEED_ZLIB=ON \
    -DZLIB_LIBRARY=$BUILD_PREFIX/lib/libz$SHLIB_EXT \
    -DHDF5_m_LIBRARY_RELEASE=$_libpath/libm$SHLIB_EXT \
    -DHDF5_rt_LIBRARY_RELEASE=$_libpath/librt$SHLIB_EXT \
    -DHDF5_dl_LIBRARY_RELEASE=$_libpath/libdl$SHLIB_EXT \
    -DHDF5_pthread_LIBRARY_RELEASE=$_libpath/libpthread$SHLIB_EXT
make -j$CPU_COUNT
if [[ `uname -s` == 'Linux' ]]; then
    ctest
fi
make install
