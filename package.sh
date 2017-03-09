#!/bin/bash

usage()
{
    echo 'Package only for Raspbian'
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

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd ${SCRIPT_DIR}/src >/dev/null 2>&1
debuild -b -us -uc
popd >/dev/null 2>&1
