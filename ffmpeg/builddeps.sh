#!/usr/bin/bash


cd ~/ffmpeg_sources
wget https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/nasm-2.16.01.tar.bz2
tar xjvf nasm-2.16.01.tar.bz2
cd nasm-2.16.01
./autogen.sh
PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"
make -j16
make -j16 install

cd ~/ffmpeg_sources
git -C x264 pull 2> /dev/null || git clone --depth 1 https://code.videolan.org/videolan/x264.git
cd x264
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static --enable-pic
PATH="$HOME/bin:$PATH" make -j16
make -j16 install


cd ~/ffmpeg_sources
wget -O x265.tar.bz2 https://bitbucket.org/multicoreware/x265_git/get/master.tar.bz2
tar xjvf x265.tar.bz2
cd multicoreware*/build/linux
PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED=off ../../source
PATH="$HOME/bin:$PATH" make -j16
make -j16 install

cd ~/ffmpeg_sources
git -C libvpx pull 2> /dev/null || git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git
cd libvpx
PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --disable-examples --disable-unit-tests --enable-vp9-highbitdepth --as=yasm
PATH="$HOME/bin:$PATH" make -j16
make -j16 install

cd ~/ffmpeg_sources
git -C libvpx pull 2> /dev/null || git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git
cd libvpx
PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --disable-examples --disable-unit-tests --enable-vp9-highbitdepth --as=yasm
PATH="$HOME/bin:$PATH" make -j16
make -j16 install


cd ~/ffmpeg_source
git -C fdk-aac pull 2> /dev/null || git clone --depth 1 https://github.com/mstorsjo/fdk-aac
cd fdk-aac
autoreconf -fiv
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make -j16
make -j16 install


cd ~/ffmpeg_source
git -C opus pull 2> /dev/null || git clone --depth 1 https://github.com/xiph/opus.git
cd opus
./autogen.sh
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make -j16
make -j16 install


cd ~/ffmpeg_sources
git -C aom pull 2> /dev/null || git clone --depth 1 https://aomedia.googlesource.com/aom
mkdir -p aom_build
cd aom_build
PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_TESTS=OFF -DENABLE_NASM=on ../aom
PATH="$HOME/bin:$PATH" make -j16
make -j16 install


cd ~/ffmpeg_sources
git -C SVT-AV1 pull 2> /dev/null || git clone https://gitlab.com/AOMediaCodec/SVT-AV1.git
mkdir -p SVT-AV1/build
cd SVT-AV1/build
PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DCMAKE_BUILD_TYPE=Release -DBUILD_DEC=OFF -DBUILD_SHARED_LIBS=OFF ..
PATH="$HOME/bin:$PATH" make -j16
make -j16 install


cd ~/ffmpeg_sources
git -C dav1d pull 2> /dev/null || git clone --depth 1 https://code.videolan.org/videolan/dav1d.git
mkdir -p dav1d/build
cd dav1d/build
meson setup -Denable_tools=false -Denable_tests=false --default-library=static .. --prefix "$HOME/ffmpeg_build" --libdir="$HOME/ffmpeg_build/lib"
ninja
ninja install


cd ~/ffmpeg_sources
wget https://github.com/Netflix/vmaf/archive/v2.3.1.tar.gz
tar xvf v2.3.1.tar.gz
mkdir -p vmaf-2.3.1/libvmaf/build
cd vmaf-2.3.1/libvmaf/build
meson setup -Denable_tests=false -Denable_docs=false --buildtype=release --default-library=static .. --prefix "$HOME/ffmpeg_build" --bindir="$HOME/ffmpeg_build/bin" --libdir="$HOME/ffmpeg_build/lib"
ninja
ninja install












