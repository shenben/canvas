#!/bin/bash
#
sudo apt update && \
sudo apt install -y build-essential bc flex bison pkg-config libssl-dev libelf-dev openssl && \
sudo apt install -y python-libxml2 gfortran swig dpatch tcl quilt  libltdl-dev libnl-route-3-200 debhelper tk graphviz chrpath pkg-config && \
sudo mkfs -t ext4 /dev/sda4  && \
sudo mkdir -p /mnt/data && \
sudo mount /dev/sda4 /mnt/data && \
sudo chmod 777 /mnt/data -R && \
cd /mnt/data && \
git clone https://github.com/shenben/canvas.git && \
# ln -s /mnt/data/canvas $HOME/canvas
cd canvas && \
cd linux-5.5 && \
cp config .config && \ 
sudo ./build_kernel.sh build && \
sudo ./build_kernel.sh install && \
sudo sed -i 's/CMDLINE_LINUX="/CMDLINE_LINUX="systemd.unified_cgroup_hierarchy=1 cgroup_no_v1=all transparent_hugepage=madvise /' /etc/default/grub && \
sudo sed -i 's/^GRUB_DEFAULT=.*/GRUB_DEFAULT="Advanced options for Ubuntu>Ubuntu, with Linux 5.5.0-canvas"/' /etc/default/grub && \
sudo sed -i 's/^GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="cgroup_enable=memory systemd.unified_cgroup_hierarchy=0 transparent_hugepage=madvise console=ttyS1,115200 emulabcnet=f0:1f:af:e2:33:a7"/' /etc/default/grub

sudo update-grub
# Change the grub parameters (at least on CPU server) /etc/default/grub
# sudo vim /etc/default/grub

# # Choose the bootup kernel version as 5.5.0-canvas
# GRUB_DEFAULT="Advanced options for Ubuntu>Ubuntu, with Linux 5.5.0-canvas"

# # Change the value of GRUB_CMDLINE_LINUX to set transparent hugepage as madvise:
# GRUB_CMDLINE_LINUX="systemd.unified_cgroup_hierarchy=1 cgroup_no_v1=all transparent_hugepage=madvise"

# # Apply the change
# sudo update-grub

#sudo reboot
sudo mount /dev/sda4 /mnt/data
cd /mnt/data/
# #wget https://content.mellanox.com/ofed/MLNX_OFED-5.0-2.1.8.0/MLNX_OFED_LINUX-5.0-2.1.8.0-ubuntu18.04-x86_64.tgz
# #tar xzf MLNX_OFED_LINUX-5.0-2.1.8.0-ubuntu18.04-x86_64.tgz
# cp -r /proj/rdmatestbench-PG0/tarfiles/MLNX_OFED_LINUX-5.0-2.1.8.0-ubuntu18.04-x86_64 ./
# # under /mnt/data/ , install MLNX_OFED drivers
# cd MLNX_OFED_LINUX-5.0-2.1.8.0-ubuntu18.04-x86_64

# sudo apt remove ibverbs-providers:amd64 librdmacm1:amd64 librdmacm-dev:amd64 libibverbs-dev:amd64 libosmvendor4 -y && \

# sudo ./mlnxofedinstall --add-kernel-support #Mellanox NICs
# sudo ./mlnxofedinstall --add-kernel-support --without-fw-update --force
#     # --without-fw-update and --force: required for non-Mellanox NICs
# sudo /etc/init.d/openibd restart


sudo apt-get install cgroup-tools
sudo mkdir -p /sys/fs/cgroup/memory
sudo mount -t cgroup -o memory cgroup /sys/fs/cgroup/memory
sudo cgcreate -t $USER -a $USER -g memory:/memctl
# # Please confirm that a memory cgroup directory is built as:
# /sys/fs/cgroup/memory/memctl