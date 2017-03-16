#!/bin/bash

RPI_USERNAME='pi'
RPI_FQDN='wguynes-rpi.local'
FRAMES_PER_SECOND=25
ROTATION_IN_DEGREES=270

ssh -t -t "${RPI_USERNAME}@${RPI_FQDN}" " \
    raspivid \
        --output - \
        --timeout 0 \
        --width 800 --height 480 \
        --hflip \
        --framerate ${FRAMES_PER_SECOND} \
        --rotation ${ROTATION_IN_DEGREES} \
        >/dev/null 2>&1 \
"
