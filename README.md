# Android Curl Builder

[![License](http://img.shields.io/:license-mit-blue.svg)](LICENSE.md)

Set of bash scripts used to cross compile curl & its dependencies for Android platform

## Compatibility

* Linux
* in construction : MAC OSX

Build for arm architecture only

## Quick start

Having previously downloaded android-ndk is recommended but nevertheless not required (download is quite lengthy): 

```
export NDK_DIR=/home/user/path/to/android-ndk
```

Set install directory (it will contain zlib, openssl & curl library + headers) :
```
export GLOBAL_INSTALL_DIR=/home/user/install_dir
```

Launch the build :

```
./build.sh
```

## Libraries built

The following libraries are built :

* zlib
* openssl
* curl

## Build dependency variables

You can precise path to the following element if you already have them and dont want to download a new version each time you want to build curl :

| build dependency element               | env path vars         |
|----------------------------------------|-----------------------|
| android-ndk                            | `NDK_DIR`             |
| android toolchain (generated from ndk) | `TOOLCHAIN_DIR`       |
| zlib                                   | `ZLIB_SOURCE_DIR`     |
| openssl                                | `OPENSSL_SOURCE_DIR`  |
| curl                                   | `CURL_SOURCE_DIR`     |

For instance, if you want to build against your own source of openssl :
```
export OPENSSL_SOURCE_DIR=/home/user/openssl
```

## Build installation path variables

You can set installation path for zlib, openssl, curl & all of them :

| target                      |      installation path variable  |
|-----------------------------|----------------------------------|
| zlib                        |    `ZLIB_INSTALL_DIR`              |
| openssl                     |    `OPENSSL_INSTALL_DIR`           |
| curl                        |    `CURL_INSTALL_DIR`              |
| curl & all its dependencies     |    `GLOBAL_INSTALL_DIR`            |

For instance, if you want to have zlib library & headers in folder `/home/user/zlib_install` :
```
export ZLIB_INSTALL_DIR=/home/user/zlib_install
```

## Build against a different Android platform 

To change Android platform set `TOOLCHAIN_PLATFORM` variables :

```
export TOOLCHAIN_PLATFORM=android-17
```

## More customization

You can configure some parameters in `config.sh` including zlib, openssl, curl release tarball to be used, openssl & curl build args etc... :

```
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
```

## License

The MIT License (MIT) Copyright (c) 2016 Bertrand Martel
