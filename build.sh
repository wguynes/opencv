#!/bin/bash

usage()
{
    echo 'Build only for Raspbian'
    exit 1
}

if [[ "$(uname)" != "Linux" ]] || [[ ! -x /usr/bin/lsb_release ]]
then
    usage
fi

/usr/bin/lsb_release -a 2>/dev/null | grep 'Raspbian' >/dev/null 2>&1
ec=$?
if [[ $ec -ne 0 ]]
then
    usage
fi

: ${PREFIX:=/usr/local}
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd "${SCRIPT_DIR}/src" >/dev/null 2>&1

mkdir -p build

pushd build >/dev/null 2>&1

{
    cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=${PREFIX} \
        -DBUILD_opencv_python2=ON \
        -DBUILD_EXAMPLES=ON \
        -DBUILD_DOCS=ON \
        -DPYTHON2_INCLUDE_PATH=/usr/include/python2.7 \
        -DWITH_TBB=ON \
        ../src \
    && \
    make -j4
} 2>&1 | tee "${SCRIPT_DIR}/build.sh.out"

popd >/dev/null 2>&1

popd >/dev/null 2>&1
