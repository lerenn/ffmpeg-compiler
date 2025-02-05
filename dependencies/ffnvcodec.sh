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

# Check if FFNVCodec installation has been executed
mkdir -p ${WORK_DIR} && cd ${WORK_DIR}
if [ -d "${WORK_DIR}/nv-codec-headers" ]; then
  echo "FFNVCodec is already installed."
  exit
fi

# Download FFNVCodec
git clone --recursive --depth 1 https://git.videolan.org/git/ffmpeg/nv-codec-headers.git

# Install FFNVCodec
cd nv-codec-headers
make install