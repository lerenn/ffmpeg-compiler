#!/usr/bin/env bash

# Set variables
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
WORK_DIR="${DIR}/build"

# Set
set -eux

# Check that the script is run as a normal user
if [ $(id -u) -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi

# libmp3lame
mkdir -p ${WORK_DIR} && cd ${WORK_DIR}
if [ ! -d "${WORK_DIR}/lame-3.100" ]; then
      curl -L -O http://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz
      tar xzvf lame-3.100.tar.gz
fi
cd lame-3.100
autoreconf --install
./configure --prefix="/usr/local" --disable-shared --enable-nasm
make -j $(nproc)
sudo make install