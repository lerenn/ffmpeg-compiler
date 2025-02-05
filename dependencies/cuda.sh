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

# Check if CUDA installation has been executed
mkdir -p ${WORK_DIR} && cd ${WORK_DIR}
if [ -d "${WORK_DIR}/cuda-toolkit" ]; then
    echo "CUDA toolkit is already installed."
    exit
fi

# Download CUDA if not present
if [ ! -f "${WORK_DIR}/cuda_12.6.3_560.35.05_linux.run" ]; then
    wget https://developer.download.nvidia.com/compute/cuda/12.6.3/local_installers/cuda_12.6.3_560.35.05_linux.run
fi

# Install CUDA
chmod +x cuda_12.6.3_560.35.05_linux.run
mkdir -p ${WORK_DIR}/cuda-toolkit
./cuda_12.6.3_560.35.05_linux.run --override --silent --toolkit --tmpdir=${WORK_DIR}/cuda-toolkit