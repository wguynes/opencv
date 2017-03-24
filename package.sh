#!/bin/bash

source utilities.sh

if [[ "$(os_type)" != 'raspbian' ]]
then
    echo 'Package only for Raspbian'
    exit 1
fi

pushd "$(script_dir)/src" >/dev/null 2>&1
debuild -b -us -uc
popd >/dev/null 2>&1
