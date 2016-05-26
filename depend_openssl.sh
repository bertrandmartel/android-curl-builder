#!/bin/bash

function log_openssl_result(){

	echo -ne "\x1B[01;93m"
	echo "-----------OPENSSL CROSS COMPILED SUCCESSFULLY----------"
	echo "| install directory : $OPENSSL_INSTALL_DIR"
	echo "| headers directory : $OPENSSL_INSTALL_DIR/include"
	echo "| library directory : $OPENSSL_INSTALL_DIR/lib"
	echo "--------------------------------------------------------"
	echo -ne "\x1B[0m"
}

function log_openssl_header(){

	echo -ne "\x1B[01;93m"
	echo "--------------------------------------------------------"
	echo "| OPENSSL_INSTALL_DIR    : $OPENSSL_INSTALL_DIR"
	echo "| OPENSSL_SOURCE_DIR     : $OPENSSL_SOURCE_DIR"
	echo "| ANDROID_NDK_ROOT       : $NDK_DIR"
	echo "| ANDROID_ARCH           : $ANDROID_ARCH"
	echo "| ANDROID_EABI           : $ANDROID_EABI"
	echo "| ANDROID_API            : $ANDROID_API"
	echo "| ANDROID_SYSROOT        : $ANDROID_SYSROOT"
	echo "| ANDROID_TOOLCHAIN      : $ANDROID_TOOLCHAIN"
	echo "| FIPS_SIG               : $FIPS_SIG"
	echo "| CROSS_COMPILE          : $CROSS_COMPILE"
	echo "| ANDROID_DEV            : $ANDROID_DEV"
	echo "| OPENSSL_CONFIG_ARGS    : $OPENSSL_CONFIG_ARGS"
	echo "| HOSTCC                 : $HOSTCC"
	echo "--------------------------------------------------------"
	echo -ne "\x1B[0m"
}

function define_openssl_install_directory(){

	echo -ne "\x1B[01;93m"
	echo "> set openssl install directory ..."
	echo -ne "\x1B[0m"

	if [ -z "$OPENSSL_INSTALL_DIR" ]; then
		OPENSSL_INSTALL_DIR="$INSTALL_DIR/$OPENSSL_DEFAULT_INSTALL_DIR"
		rm -rf $OPENSSL_INSTALL_DIR
	fi
}

function get_openssl(){

	if [ -z "$OPENSSL_SOURCE_DIR" ]; then

		echo -ne "\x1B[01;93m"
		echo "> downloading openssl ..."
		echo -ne "\x1B[0m"
		rm -rf $INSTALL_DIR/openssl-*
		wget -q --show-progress -P $INSTALL_DIR $OPENSSL_TARBALL
		TAR_FILE=`echo $OPENSSL_TARBALL | grep -oP "[^/]*$"`
		tar -xzf $INSTALL_DIR/$TAR_FILE -C $INSTALL_DIR
		rm $INSTALL_DIR/$TAR_FILE
	fi
}

function build_openssl(){

	echo -ne "\x1B[01;93m"
	echo "> building openssl ..."
	echo -ne "\x1B[0m"

	cd $INSTALL_DIR/openssl-*
	
	export CC=""
	export AR=""
	export AS=""
	export LD=""
	export NM=""
	export RANLIB=""

	export ANDROID_NDK_ROOT="$NDK_DIR"
	export ANDROID_API="$TOOLCHAIN_PLATFORM"
	export MACHINE=armv7
	export RELEASE=2.6.37
	export SYSTEM=android
	export ARCH=arm
	export CROSS_COMPILE="arm-linux-androideabi-"

	if [ "$ANDROID_ARCH" == "arch-x86" ]; then
		export MACHINE=i686
		export RELEASE=2.6.37
		export SYSTEM=android
		export ARCH=x86
		export CROSS_COMPILE="i686-linux-android-"
	fi

	export ANDROID_SYSROOT="$ANDROID_TOOLCHAIN/sysroot"
	export SYSROOT="$ANDROID_SYSROOT"
	export NDK_SYSROOT="$ANDROID_SYSROOT"
	export ANDROID_NDK_SYSROOT="$ANDROID_SYSROOT"
	export ANDROID_DEV="$ANDROID_TOOLCHAIN/sysroot/usr"
	export HOSTCC=gcc

	log_openssl_header

	perl -pi -e 's/install: all install_docs install_sw/install: install_docs install_sw/g' Makefile.org
	./config $OPENSSL_CONFIG_ARGS --openssldir=$OPENSSL_INSTALL_DIR
	make depend
	make all -j16
	make install

	log_openssl_result
}

function move_openssl_output(){
	if [ ! -z "$GLOBAL_INSTALL_DIR" ]; then
		mkdir -p $GLOBAL_INSTALL_DIR/include
		cp -rf $OPENSSL_INSTALL_DIR/include/* $GLOBAL_INSTALL_DIR/include/
		cp -rf $OPENSSL_INSTALL_DIR/lib/* $GLOBAL_INSTALL_DIR/
	fi
}

function depend_openssl(){

	echo -ne "\x1B[01;93m"
	echo "--------------------------------------------------------"
	echo "|                    OPENSSL TASK                      |"
	echo "--------------------------------------------------------"
	echo -ne "\x1B[0m"

	define_openssl_install_directory
	get_openssl
	build_openssl
	move_openssl_output
}