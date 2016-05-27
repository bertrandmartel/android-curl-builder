#!/bin/bash

DEFAULT_OS="LINUX"
DEFAULT_INSTALL_DIR="/tmp"
NDK_INSTALL_DEFAULT_DIR="ndk"
NDK_LINK_LINUX="http://dl.google.com/android/repository/android-ndk-r11c-linux-x86_64.zip"
NDK_LINK_MACOSX="http://dl.google.com/android/repository/android-ndk-r11c-darwin-x86_64.zip"
TOOLCHAIN_DEFAULT_DIR="toolchain"

if [ -z "$TOOLCHAIN_PLATFORM" ]; then
	TOOLCHAIN_PLATFORM="android-21"
fi

CROSS_COMPILE="arm-linux-androideabi"
ANDROID_CC="${CROSS_COMPILE}-gcc"
ANDROID_AR="${CROSS_COMPILE}-ar"
ANDROID_AS="${CROSS_COMPILE}-as"
ANDROID_LD="${CROSS_COMPILE}-ld"
ANDROID_NM="${CROSS_COMPILE}-nm"
ANDROID_RANLIB="${CROSS_COMPILE}-ranlib"
ZLIB_TARBALL="http://zlib.net/zlib-1.2.8.tar.gz"
ZLIB_DEFAULT_INSTALL_DIR="zlib"
OPENSSL_DEFAULT_INSTALL_DIR="openssl"
OPENSSL_TARBALL="https://www.openssl.org/source/openssl-1.0.1p.tar.gz"
ANDROID_EABI="arm-linux-androideabi-4.8"
ANDROID_ARCH="arch-arm"
OPENSSL_CONFIG_ARGS="shared no-ssl2 no-ssl3 no-comp no-hw no-engine"
CURL_DEFAULT_INSTALL_DIR="curl"
CURL_TARBALL="https://github.com/curl/curl/archive/curl-7_49_0.tar.gz"
CURL_ARGS="--with-ssl --with-zlib --disable-ftp --disable-gopher 
	--disable-file --disable-imap --disable-ldap --disable-ldaps 
	--disable-pop3 --disable-proxy --disable-rtsp --disable-smtp 
	--disable-telnet --disable-tftp --without-gnutls --without-libidn 
	--without-librtmp --disable-dict"
BUILD_ZLIB=1
BUILD_OPENSSL=1
BUILD_INTERACTIVE=0
BUILD_DEPENDENCY=( "wget" "make" "tar" "perl" "makedepend" "autoconf" "autoreconf" )