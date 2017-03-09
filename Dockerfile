FROM resin/rpi-raspbian

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade --yes

RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
    apt-utils \
    build-essential \
    cmake \
    debhelper \
    devscripts \
    dialog \
    doxygen \
    fakeroot \
    g++ \
    git \
    less \
    libavcodec-dev \
    libavformat-dev \
    libdc1394-22-dev \
    libgtk2.0-dev \
    libjasper-dev \
    libjpeg-dev \
    libpng-dev \
    libpython2.7-dev \
    libswscale-dev \
    libtiff-dev \
    lsb-release \
    make \
    pkg-config \
    python-dev \
    python-numpy \
    unzip \
    vim

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
