#!/bin/bash

PORT=8090

#ssh rpi -T <<EOT
#    /usr/bin/raspivid \
#        -o - \
#        -t 0 \
#        -w 640 -h 360 \
#        -fps 25 \
#        | \
#        cvlc -vvv stream:///dev/stdin \
#        --sout '#standard{access=http,mux=ts,dst=:${PORT}}' :demux=h264
#EOT 

ssh rpi -T <<EOSSH
COUNTER=0
while true
do
    echo \${COUNTER}
    sleep 1
    let COUNTER=COUNTER+1 
done
EOSSH
