#!/bin/bash

source utilities.sh

: ${PREFIX:=/usr/local}
SRC_DIR="$(script_dir)/src"

OS_TYPE="$(os_type)"
NUMBER_OF_JOBS=
if [[ "${OS_TYPE}" == 'raspbian' ]]
then
    NUMBER_OF_JOBS=4
elif [[ "${OS_TYPE}" == 'osx' ]]
then
    NUMBER_OF_JOBS=8
else
    echo 'Not Raspbian or OSX environment' >&2
    exit 1
fi

BUILD_DIR="${SRC_DIR}/build_${OS_TYPE}"
LOG_FILE="${BUILD_DIR}.log"

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
    make -j${NUMBER_OF_JOBS}
} 2>&1 | tee "${LOG_FILE}"

popd >/dev/null 2>&1

popd >/dev/null 2>&1
