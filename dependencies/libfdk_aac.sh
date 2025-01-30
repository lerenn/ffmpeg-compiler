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

# libfdk_aac
mkdir -p ${WORK_DIR} && cd ${WORK_DIR}
if [ ! -d "${WORK_DIR}/fdk-aac" ]; then
      git clone git://git.code.sf.net/p/opencore-amr/fdk-aac
fi
cd fdk-aac
autoreconf -fiv
./configure --prefix="/usr/local" --disable-shared
make -j $(nproc)
sudo make install