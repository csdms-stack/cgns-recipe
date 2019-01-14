#! /usr/bin/env bash

mkdir _build && cd _build
cmake .. \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCGNS_ENABLE_FORTRAN=ON \
    -DCGNS_ENABLE_HDF5=ON \
    -DCGNS_ENABLE_TESTS=ON \
    -DHDF5_NEED_ZLIB=ON \
    -DZLIB_LIBRARY=$BUILD_PREFIX/lib/libz.so \
    -DHDF5_m_LIBRARY_RELEASE=$BUILD_PREFIX/$HOST/sysroot/usr/lib/libm.so \
    -DHDF5_rt_LIBRARY_RELEASE=$BUILD_PREFIX/$HOST/sysroot/usr/lib/librt.so
make -j$CPU_COUNT
ctest
make install
