# Android Curl Builder (ACB)

[![License](http://badge.kloud51.com/pypi/l/html2text.svg)](LICENSE.md)

Set of bash scripts used to cross compile curl & its dependencies for Android platform

## Compatibility

* Linux
* MAC OSX

Build for arm architecture only

## Help

```
Usage : acb [ARGUMENTS...]
acb build curl for Android platform with its dependencies

Example:
  acb -ndk=/home/user/ndk -android_platform=android-17 -global_install=/home/user/install_dir

Arguments:

  -ndk=[PATH]                   specify ndk directory path
  -android_platform=[PLATFORM]  specify target android platform (android-XX)
  -toolchain=[PATH]             specify path to android toolchain
  -zlib_src=[PATH]              specify path to zlib source directory
  -openssl_src=[PATH]           specify path to openssl source directory
  -curl_src=[PATH]              specify path to curl source directory
  -zlib_install=[PATH]          specify path to zlib install directory
  -openssl_install=[PATH]       specify path to openssl install directory
  -curl_install=[PATH]          specify path to curl install directory
  -global_install=[PATH]        specify path to global install directory (curl and its dependencies release will be copied to this directory)
  --disable-zlib-build          wont build zlib if zlib install directory is specified
  --disable-openssl-build       wont build openssl if openssl install directory is specified
  -v, --version                 show version
  -h, --help                    show help
```

## Libraries built

The following libraries are cross compiled for Android platform :

* zlib
* openssl
* curl

## Utilities required

* wget
* make
* tar
* perl
* makedepend
* autoconf
* automake

## Troubleshoot

If you have any troubles / questions, please create <a href="https://github.com/akinaru/android-curl-builder/issues/new">an issue</a>

## License

```
Copyright (C) 2016  Bertrand Martel

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 3
of the License, or (at your option) any later version.

Foobar is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
```