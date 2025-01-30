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

# libx265
mkdir -p ${WORK_DIR} && cd ${WORK_DIR}
if [ ! -d "${WORK_DIR}/x265" ]; then
      git clone https://bitbucket.org/multicoreware/x265_git x265
fi
mkdir -p ${WORK_DIR}/x265/build/linux && cd ${WORK_DIR}/x265/build/linux
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/usr/local" -DENABLE_SHARED:bool=off ../../source
make -j $(nproc)
sudo make install