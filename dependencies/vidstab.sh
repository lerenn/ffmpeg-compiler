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

# Vidstab
mkdir -p ${WORK_DIR} && cd ${WORK_DIR}
if [ ! -d "${WORK_DIR}/vid.stab" ]; then
      git clone --recursive https://github.com/georgmartius/vid.stab.git
fi
cd vid.stab
cmake . \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX="/usr/local" \
      -DCMAKE_MACOSX_RPATH=ON \
      -DCMAKE_INSTALL_RPATH="/usr/local/lib"
make
sudo make install
