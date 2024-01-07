#!/bin/bash

# Build emacs for fedora
arch=$(uname -m)
emacs_pkg_version="0.0.0.0"
branch="emacs-29"
emacs_dest_dir="$(pwd)"
emacs_src_dir="$(pwd)"
output_dir=$(pwd)/pkg/dnf
mkdir -p $output_dir/usr/local/

sudo dnf4 builddep emacs
sudo dnf install libgccjit libgccjit-devel gtk3 gtk3-devel gtk4 gtk4-devel libtree-sitter libtree-sitter-devel \
    jansson-devel libvterm-devel webkit2gtk4.0-devel gnutls-devel

# clone latest emacs
#git clone --single-branch --branch=$branch git://git.sv.gnu.org/emacs.git git/$branch
cd git/$branch

# Build and install (emacs-29)
./autogen.sh
./configure --without-compress-install --with-cairo --with-gif --with-gnutls --with-harfbuzz --with-jpeg --with-lcms2 --with-png --with-tiff --with-xml2 --with-xpm --with-zlib --with-pgtk --with-native-compilation=aot \
            --with-tree-sitter --with-json --with-mailutils --with-rsvg --with-sqlite3 --with-threads \
            CFLAGS="-O2 -mtune=native -march=native -fomit-frame-pointer" prefix=/usr/local

make -j16 install-strip DESTDIR=$output_dir

# Install
# sudo make install

# Uninstall
# sudo make uninstall
# make clean
# make distclean
