#!/bin/bash
set -e  # Exit immediately if any command fails

# === Install custom librga ===
git clone https://github.com/SergeyKharenko/librga.git --depth 1 librga
cd librga
mkdir -p /usr/include/rga
cp -af include/* /usr/include/rga/                                  # Copy header files
cp -af libs/Linux/gcc-aarch64/* /usr/lib/aarch64-linux-gnu/         # Copy aarch64 libraries
cp -af pkgconfig/aarch64/librga.pc /usr/lib/aarch64-linux-gnu/pkgconfig/    # Install pkg-config file
cd ..
rm -rf librga                                                       # Cleanup source directory

# === Install latest release of mpp ===
git clone https://github.com/HermanChen/mpp.git --depth 1 mpp
cd mpp
cmake -G Ninja -DCMAKE_INSTALL_PREFIX=/usr .                        # Configure build, install to /usr
ninja                                                               # Build
ninja install                                                       # Install into rootfs
cd ..
rm -rf mpp                                                          # Cleanup source directory

# === Install gst-plugins-rockchip ===
git clone https://github.com/SergeyKharenko/gst-plugins-rockchip.git --depth=1 gst-plugins-rockchip
cd gst-plugins-rockchip/
mkdir build
cd build
meson setup --prefix=/usr ..                                        # Configure Meson build, install to /usr
ninja                                                               # Build
ninja install                                                       # Install GStreamer plugin
cd ../../
rm -rf gst-plugins-rockchip                                         # Cleanup source directory