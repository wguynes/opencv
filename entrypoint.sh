#!/bin/bash

deluser --quiet ${HOST_USERNAME} >/dev/null 2>&1
delgroup --quiet ${HOST_USERNAME} >/dev/null 2>&1

adduser \
    --no-create-home \
    --home ${HOST_USERHOME} \
    --disabled-password \
    --gecos '' \
    --uid ${HOST_UID} \
    ${HOST_USERNAME} >/dev/null 2>&1
adduser ${HOST_USERNAME} sudo >/dev/null 2>&1

sudo -u ${HOST_USERNAME} -- bash -c "cd ${HOST_PWD};exec /bin/bash"
