## Stream a large directory across to another machine

SCP is too slow
```
ssh user@machine-where-precious-data-is "tar czpf - /some/important/data" | tar xzpf - -C /new/root/directory
tar cpf - /some/important/data | ssh user@destination-machine "tar xpf - -C /some/directory/"
```
## Stream video to VLC client on network
```
/usr/bin/raspivid -o - -t 0 -fps 25 | \
    -w 640 -h 360 \
    cvlc -vvv stream:///dev/stdin \
    --sout '#standard{access=http,mux=ts,dst=:8090}' :demux=h264
```
## Mount the raspberry pi camera as a device /dev/video0
```
sudo modprobe bcm2835-v4l2
```
