#!/bin/bash

VLC_APPNAME='VLC'
VIDEO_CAMERA_FQDN='wguynes-rpi.local'
PORT=8090

function kill_vlc {
    trap '' SIGINT
    kill -KILL $(pgrep ${VLC_APPNAME})
}
trap kill_vlc SIGINT

(
    open /Applications/${VLC_APPNAME}.app --args http://${VIDEO_CAMERA_FQDN}:${PORT}/
) &

ssh -t -t rpi "
    /usr/bin/raspivid \
        -o - \
        -t 0 \
        -w 640 -h 360 \
        -fps 25 \
        | \
        cvlc -vvv stream:///dev/stdin \
        --sout '#standard{access=http,mux=ts,dst=:${PORT}}' :demux=h264
"

kill_vlc
