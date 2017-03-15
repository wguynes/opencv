#!/bin/bash

VLC_APPNAME='VLC'
RPI_USERNAME='pi'
RPI_FQDN='wguynes-rpi.local'
RPI_PORT=8090
FRAMES_PER_SECOND=25

function kill_vlc {
    trap '' SIGINT
    VLC_PID=$(pgrep ${VLC_APPNAME})
    if [ -n ${VLC_PID} ]
    then
        kill -KILL ${VLC_PID}
    fi
}
trap kill_vlc SIGINT

(
    open /Applications/${VLC_APPNAME}.app --args \
        http://${RPI_FQDN}:${RPI_PORT}/
) &

ssh -t -t "${RPI_USERNAME}@${RPI_FQDN}" " \
    raspivid \
        --output - \
        --width 800 --height 480 \
        --rotation 270 \
        --timeout 0 \
        --framerate ${FRAMES_PER_SECOND} \
        --metering backlit \
        | \
        cvlc \
        -vvv \
        stream:///dev/stdin \
        --sout '#standard{access=http,mux=ts,dst=:${RPI_PORT}}' \
        :demux=h264 \
"

kill_vlc
