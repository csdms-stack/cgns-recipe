#! /usr/bin/env bash

export HDF_LIB=$BUILD_PREFIX/lib/libhdf5.so
export HDF_INC=$BUILD_PREFIX/include
export ZLIB_LIB=$BUILD_PREFIX/lib/libz.so

mkdir _build && cd _build
cmake .. \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_C_FLAGS:STRING=-D_LARGEFILE64_SOURCE \
    -DCGNS_ENABLE_HDF5=YES \
    -DHDF5_INCLUDE_PATH=$HDF_INC \
    -DHDF5_LIBRARY=$HDF_LIB \
    -DHDF5_NEED_SZIP=NO \
    -DHDF5_NEED_ZLIB=YES \
    -DZLIB_LIBRARY=$ZLIB_LIB \
    -DCGNS_ENABLE_FORTRAN=YES \
    -DCGNS_ENABLE_LFS=YES \
    -DCGNS_ENABLE_TESTS=YES \
    -DCGNS_BUILD_SHARED=YES \
    -DCGNS_USE_SHARED=YES \

make -j$CPU_COUNT
# ctest --output-on-failure
make install
