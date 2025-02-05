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

# Install CUDA drivers
dnf config-manager addrepo --overwrite \
  --from-repofile=https://developer.download.nvidia.com/compute/cuda/repos/fedora41/$(uname -m)/cuda-fedora41.repo -y
dnf module disable nvidia-driver -y || true
dnf -y install cuda-drivers