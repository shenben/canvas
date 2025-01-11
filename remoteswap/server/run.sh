#!/bin/bash -x
make clean
make && \
./rswap-server 128.110.219.164 9400 16 8
