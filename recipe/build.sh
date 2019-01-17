#! /usr/bin/env bash

export MACOSX_DEPLOYMENT_TARGET=""

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
    -DZLIB_LIBRARY=$BUILD_PREFIX/lib/libz.so \
    -DHDF5_m_LIBRARY_RELEASE=$BUILD_PREFIX/$HOST/sysroot/usr/lib/libm.so \
    -DHDF5_rt_LIBRARY_RELEASE=$BUILD_PREFIX/$HOST/sysroot/usr/lib/librt.so \
    -DHDF5_dl_LIBRARY_RELEASE=$BUILD_PREFIX/$HOST/sysroot/usr/lib/libdl.so \
    -DHDF5_pthread_LIBRARY_RELEASE=$BUILD_PREFIX/$HOST/sysroot/usr/lib/libpthread.so
make -j$CPU_COUNT
# ctest
make install
