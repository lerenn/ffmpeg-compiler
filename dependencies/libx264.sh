#!/usr/bin/env bash

# Set variables
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
WORK_DIR="${DIR}/../build"

# Set
set -eux

# Check that the script is run as a normal user
if [ $(id -u) -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi

# Check if libx264 installation has been executed
mkdir -p ${WORK_DIR} && cd ${WORK_DIR}
if [ -d "${WORK_DIR}/x264" ]; then
  echo "libx264 is already installed."
  exit
fi

# Download libx264
git clone --recursive --depth 1 https://code.videolan.org/videolan/x264.git

# Build libx264
cd x264
./configure --prefix="/usr/local"
make -j $(nproc)

# Install libx264
make install