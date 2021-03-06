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
v4l2-ctl --set-ctrl=rotate=270
```
## Create Raspbian PI sdcard
```
curl -O https://downloads.raspberrypi.org/raspbian/images/raspbian-2017-03-03/2017-03-02-raspbian-jessie.zip
unzip 2017-03-02-raspbian-jessie.zip
sudo dd bs=1m if=2017-01-11-raspbian-jessie.img of=/dev/rdisk2
sync
eject card
```
## Use configuration menu on pi
```
sudo raspi-config
1. Expand Filesystem
2. Change User Password, current is "raspberry"
3. Internationalization options
  1. Change Timezone to US -> Central
  2. Change Keyboard Layout to "104-key PC" -> Other -> "English (US)" -> No AltGr key -> No compose key -> Ctrl-Alt-BS not stop server
4. Enable Camera
5. Advanced Options
  1. Change Hostname
  2. SSH Server -> Enabled
Exit and Reboot
```
## Configure Wifi
```
sudo vi /etc/network/interfaces

allow-hotplug wlan0
auto wlan0
    iface wlan0 inet dhcp
    wpa-ssid "<network ssid>"
    wpa-psk "<password>"

sudo ifdown wlan0
sudo ifup wlan0
```
## Upgrade Raspbian to latest packages and install new ones I need
```
sudo DEBIAN_FRONTEND=noninteractive bash -c ' \
apt-get update && \
apt-get upgrade --yes && \
apt-get install --yes vlc-nox vim \
'
```
## Allow passwordless SSH access
```
ssh pi@<hostname> 'mkdir /home/pi/.ssh; chmod 700 /home/pi/.ssh'
scp ~/.ssh/id_rsa.pub pi@<hostname>:/home/pi/.ssh/authorized_keys

ssh pi@<hostname>
```
## Set up VINO framebuffer vnc service
```
gsettings set org.gnome.Vino prompt-enabled false && \
gsettings set org.gnome.Vino authentication-methods "['vnc']" && \
gsettings set org.gnome.Vino require-encryption false && \
gsettings set org.gnome.Vino vnc-password "$(echo -n "insertnewpass" | base64)"
```
Run vino-server to test
```
DISPLAY=:0 /usr/lib/vino/vino-server
```
Configure vino-server to start at boot time
```
sudo vi /etc/xdg/autostart/vino-server.desktop

[Desktop Entry]
Name=Desktop Sharing
Comment=GNOME Desktop Sharing Server
Exec=/usr/lib/vino/vino-server
Terminal=false
Type=Application
X-GNOME-Autostart-Phase=Applications
X-GNOME-AutoRestart=true
NoDisplay=true

Reboot machine
```

