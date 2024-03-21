#!/usr/bin/bash

cd

scp 10.10.20.10:/home/buts/ffmpeg.tar.xz .
tar -xvf ffmpeg.tar.xz
cd ffmpeg

./aptdeps.sh
./builddeps.sh
./ffmpeg.sh


