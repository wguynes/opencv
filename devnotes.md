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

## Create Raspbian PI sdcard
```
curl -O https://downloads.raspberrypi.org/raspbian/images/raspbian-2017-03-03/2017-03-02-raspbian-jessie.zip
unzip 2017-03-02-raspbian-jessie.zip
sudo dd bs=1m if=2017-01-11-raspbian-jessie.img of=/dev/rdisk2
sync

sudo raspi-config
1. expand filesystem
2. change user password, current is "raspberry"
3. internationalization options
  change timzone US -> Central
  change keyboard layout "104-key PC" -> Other -> "English (US)" -> No AltGr key -> No compose key -> Ctrl-Alt-BS not stop server
4. enable camera
5. Advanced Options
    change hostname
    ssh server -> enabled
Exit and reboot

/etc/network/interfaces
allow-hotplug wlan0
auto wlan0
iface wlan0 inet dhcp
    wpa-ssid "ssid"
    wpa-psk "password"

sudo ifdown wlan0
sudo ifup wlan0

sudo apt-get update
sudo apt-get upgrade --yes

ssh pi@wguynes-rpi.local 'mkdir /home/pi/.ssh; chmod 700 /home/pi/.ssh'
scp ~/.ssh/id_rsa.pub pi@wguynes-rpi.local:/home/pi/.ssh/authorized_keys
ssh pi@wguynes-rpi.local
```

gsettings set org.gnome.Vino prompt-enabled false

DISPLAY=:0 gsettings set org.gnome.Vino authentication-methods "['none']"
DISPLAY=:0 gsettings set org.gnome.Vino authentication-methods "['vnc']"
DISPLAY=:0 gsettings set org.gnome.Vino require-encryption false
DISPLAY=:0 gsettings set org.gnome.Vino vnc-password "$(echo -n "insertnewpass" | base64)"
DISPLAY=:0 gsettings set org.gnome.Vino vnc-password "$(echo -n "homeyhi1l" | base64)"
$ sudo apt-get install gnome-keyring
DISPLAY=:0 /usr/lib/vino/vino-server
