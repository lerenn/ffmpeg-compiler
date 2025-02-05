#!/usr/bin/env bash

# Set variables
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
WORK_DIR="${DIR}/build"

# Set
set -eux

# Check that the script is run as a normal user
if [ $(id -u) -ne 0 ]; then
    echo Please run this script as root or using sudo!
    exit
fi

# Check that the dir exists
if [ ! -d "${WORK_DIR}/ffmpeg" ]; then
    echo "Please run build.sh first!"
    exit
fi

# Install ffmpeg
cd ${WORK_DIR}/ffmpeg
make install
hash -r
