#!/bin/bash -x
make clean
make && \
sudo ./rswap-server 10.10.2.1 9400 8 4
