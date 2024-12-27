#!/bin/bash
sudo apt-get update && sudo apt-get -y install build-essential bc flex bison pkg-config libssl-dev libelf-dev openssl

sudo apt-get install -y linux-tools-common linux-tools-generic linux-tools-`uname -r` # linux-cloud-tools-`uname -r`

sudo apt install -y python-libxml2 gfortran swig dpatch tcl quilt \
         libltdl-dev libnl-route-3-200 debhelper tk graphviz  \
         chrpath pkg-config #libgfortran3

sudo apt-get install -y libibverbs1 ibverbs-utils librdmacm1 libibumad3 ibverbs-providers rdma-core
sudo apt-get install -y iproute2 perftest

sudo apt install -y software-properties-common apt-transport-https wget  cmake vim git curl 
sudo apt install  autoconf dh-autoreconf libcurl4-openssl-dev \
                 tcl-dev docbook2x install-info \
                 libexpat1-dev libz-dev -y
sudo apt install libdwarf-dev libelf-dev libnuma-dev libperl-dev python3-dev python2-dev libunwind-dev zlib1g-dev liblzma-dev libaio-dev libzstd-dev -y