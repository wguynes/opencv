#!/bin/bash

source utilities.sh

: ${PREFIX:=/usr/local}
SRC_DIR="$(script_dir)/src"

if [[ "$(os_type)" == 'raspbian' ]]
then
    BUILD_DIR="${SRC_DIR}/build_raspbian"
    LOG_FILE="${SRC_DIR}/build_raspbian.log"
else
    echo 'Not raspbian os' >&2
    exit 1
fi

pushd "${SRC_DIR}" >/dev/null 2>&1

mkdir -p "${BUILD_DIR}"

pushd "${BUILD_DIR}" >/dev/null 2>&1

{
    cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
        -DBUILD_opencv_python2=ON \
        -DBUILD_EXAMPLES=ON \
        -DBUILD_DOCS=ON \
        -DPYTHON2_INCLUDE_PATH=/usr/include/python2.7 \
        -DWITH_TBB=ON \
        ../src \
    && \
    make -j4
} 2>&1 | tee "${LOG_FILE}"

popd >/dev/null 2>&1

popd >/dev/null 2>&1
