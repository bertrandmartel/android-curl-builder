#!/bin/bash

set -e
CURRENT_DIR=`pwd`
VERSION="1.0"
RELEASE_DATE="05-23-2016"

source config.sh
source setup_functions.sh
source depend_zlib.sh
source depend_openssl.sh
source depend_curl.sh

print_header
os_check
set_config
set_install_dir
setup_ndk
setup_toolchain
check_build_args
add_to_path

log_global_vars

if [ "$BUILD_INTERACTIVE" == 1 ]; then

	read -p "Do you want to build curl with these settings ? (y/n) " -n 1 -r
	echo
	if [[ ! $REPLY =~ ^[Yy]$ ]]
	then
		echo "> edit config.sh vars"
	    exit 1
	fi
fi

if [ "$BUILD_ZLIB" == 1 ]; then
	depend_zlib
fi

if [ "$BUILD_OPENSSL" == 1 ]; then 
	depend_openssl
fi

depend_curl