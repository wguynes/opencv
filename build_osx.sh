#!/bin/bash

: ${PREFIX:=/usr/local}
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd "${SCRIPT_DIR}/src" >/dev/null 2>&1

mkdir -p build_osx

pushd build_osx >/dev/null 2>&1

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DBUILD_opencv_python2=ON \
    -DBUILD_EXAMPLES=ON \
    -DBUILD_DOCS=ON \
    -DPYTHON2_INCLUDE_PATH=/usr/include/python2.7 \
    -DWITH_TBB=ON \
    ../src
#make -j8

popd >/dev/null 2>&1

popd >/dev/null 2>&1
