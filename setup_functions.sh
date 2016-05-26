#!/bin/bash

function print_error(){

	echo -ne "\x1B[31m"
	echo "$1"
	echo -ne "\x1B[0m"
}

function os_check(){

	case "$OSTYPE" in
	darwin*)  
		OS="OSX"
		;; 
	linux*)
		OS="LINUX"
		;;
	esac

	if [ -z "$OS" ]; then
		read -p "OS not supported. Do you want to continue ? (y/n) " -n 1 -r
		echo
		if [[ ! $REPLY =~ ^[Yy]$ ]]
		then
			print_error "aborting"
		    exit 1
		fi
	fi
}

function set_config(){
	
	case "$OS" in
	LINUX*)  
		NDK_LINK="$NDK_LINK_MACOSX"
		;; 
	OSX*)
		NDK_LINK="$NDK_LINK_LINUX"
		;;
	esac
}

function set_install_dir(){

	if [ -z "$INSTALL_DIR" ]; then
		INSTALL_DIR="$DEFAULT_INSTALL_DIR"
	fi

	mkdir -p "$INSTALL_DIR"
}

function setup_ndk(){

	if [ -z "$NDK_DIR" ]; then
		echo "downloading NDK ..."
		NDK_DIR="$INSTALL_DIR/$NDK_INSTALL_DEFAULT_DIR"
		wget  -q --show-progress -P "$NDK_DIR" "$NDK_LINK"
	fi
}

function setup_toolchain(){

	if [ -z "$TOOLCHAIN_DIR" ]; then
		ANDROID_TOOLCHAIN="$INSTALL_DIR/$TOOLCHAIN_DEFAULT_DIR"
		$NDK_DIR/build/tools/make-standalone-toolchain.sh --arch=arm --platform="$TOOLCHAIN_PLATFORM" --install-dir="$ANDROID_TOOLCHAIN"
	fi
}

function check_build_args(){

	if [ "$BUILD_ZLIB" == 0 ] && [ -z "$ZLIB_INSTALL_DIR" ]; then
		print_error "You must specify ZLIB_INSTALL_DIR when disabling BUILD_ZLIB"
		exit 1
	fi 

	if [ "$BUILD_OPENSSL" == 0 ] && [ -z "$OPENSSL_INSTALL_DIR" ]; then
		print_error "You must specify OPENSSL_INSTALL_DIR when disabling BUILD_OPENSSL"
		exit 1
	fi 
}

function add_to_path(){

	export PATH=$PATH:$NDK_DIR/bin:$ANDROID_TOOLCHAIN/bin
}

function log_global_vars(){

	echo -ne "\x1B[01;32m"
	echo "--------------------------------------------------------"
	echo "| OS                     : $OS"
	echo "| INSTALL_DIR            : $INSTALL_DIR"
	echo "| NDK_DIR                : $NDK_DIR"
	echo "| TOOLCHAIN_DIR          : $ANDROID_TOOLCHAIN"
	echo "| BUILD_ZLIB             : $BUILD_ZLIB"
	echo "| BUILD_OPENSSL          : $BUILD_OPENSSL"
	echo "| TOOLCHAIN_PLATFORM     : $TOOLCHAIN_PLATFORM"
	echo "| CROSS_COMPILE          : $CROSS_COMPILE"
	echo "| ANDROID_CC             : $ANDROID_CC"
	echo "| ANDROID_AR             : $ANDROID_AR"
	echo "| ANDROID_AS             : $ANDROID_AS"
	echo "| ANDROID_LD             : $ANDROID_LD"
	echo "| ANDROID_NM             : $ANDROID_NM"
	echo "| ANDROID_RANLIB         : $ANDROID_RANLIB"
	echo "| ZLIB_TARBALL           : $ZLIB_TARBALL"
	echo "| OPENSSL_TARBALL        : $OPENSSL_TARBALL"
	echo "| ANDROID_EABI           : $ANDROID_EABI"
	echo "| ANDROID_ARCH           : $ANDROID_ARCH"
	echo "| OPENSSL_CONFIG_ARGS    : $OPENSSL_CONFIG_ARGS"
	echo "| CURL_TARBALL           : $CURL_TARBALL"
	echo "| CURL_ARGS              : $CURL_ARGS"
	echo "--------------------------------------------------------"
	echo -ne "\x1B[0m"
}

function print_header(){

	echo "--------------------------------------------------------"
	echo "|  Android Curl Builder tool version $VERSION ($RELEASE_DATE)  |"
	echo "|  The MIT License Copyright (c) 2016 Bertrand Martel  |"
	echo "--------------------------------------------------------"
}