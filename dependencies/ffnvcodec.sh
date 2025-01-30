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

# FFNVCodec
mkdir -p ${WORK_DIR} && cd ${WORK_DIR}
if [ ! -d "${WORK_DIR}/nv-codec-headers" ]; then
      git clone --recursive https://git.videolan.org/git/ffmpeg/nv-codec-headers.git
fi
cd nv-codec-headers
sudo make install