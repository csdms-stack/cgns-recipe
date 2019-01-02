#! /usr/bin/env bash

mkdir _build && cd _build
cmake .. \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_SHARED_LINKER_FLAGS=-lhdf5 \
    -DCGNS_ENABLE_HDF5=YES \
    -DHDF5_NEED_SZIP=NO \
    -DHDF5_NEED_ZLIB=YES \
    -DCGNS_ENABLE_FORTRAN=YES \
    -DCGNS_ENABLE_LFS=YES \
    -DCGNS_ENABLE_TESTS=YES \
    -DCGNS_BUILD_SHARED=YES \
    -DCGNS_USE_SHARED=YES \

make
ctest --output-on-failure
make install
