#!/bin/bash

function log_zlib_result(){

	echo -ne "\x1B[01;32m"
	echo "-------------ZLIB CROSS COMPILED SUCCESSFULLY-----------"
	echo "| install directory : $ZLIB_INSTALL_DIR"
	echo "| headers directory : $ZLIB_INSTALL_DIR/include"
	echo "| library directory : $ZLIB_INSTALL_DIR/lib"
	echo "--------------------------------------------------------"
	echo -ne "\x1B[0m"
}

function log_zlib_header(){

	echo -ne "\x1B[01;32m"
	echo "--------------------------------------------------------"
	echo "| ZLIB_INSTALL_DIR    : $ZLIB_INSTALL_DIR"
	echo "| ZLIB_SOURCE_DIR     : $ZLIB_SOURCE_DIR"
	echo "--------------------------------------------------------"
	echo -ne "\x1B[0m"
}

function define_zlib_install_directory(){

	echo -ne "\x1B[01;32m"
	echo "> set zlib install directory ..."
	echo -ne "\x1B[0m"

	if [ -z "$ZLIB_INSTALL_DIR" ]; then
		ZLIB_INSTALL_DIR="$INSTALL_DIR/$ZLIB_DEFAULT_INSTALL_DIR"
		rm -rf $ZLIB_INSTALL_DIR
	fi
	export prefix=$ZLIB_INSTALL_DIR
}

function get_zlib(){
	
	if [ -z "$ZLIB_SOURCE_DIR" ]; then
		echo -ne "\x1B[01;32m"
		echo "> downloading zlib ..."
		echo -ne "\x1B[0m"
		rm -rf $INSTALL_DIR/zlib-*
		wget -q --show-progress -P $INSTALL_DIR $ZLIB_TARBALL
		TAR_FILE=`echo "${ZLIB_TARBALL##*/}"`
		tar -xzf $INSTALL_DIR/$TAR_FILE -C $INSTALL_DIR
		rm $INSTALL_DIR/$TAR_FILE
	fi
}

function build_zlib(){

	echo -ne "\x1B[01;32m"
	echo "> building zlib ..."
	echo -ne "\x1B[0m"

	cd $CURRENT_DIR
	source config.sh
	
	export CC="$ANDROID_CC"
	export AR="$ANDROID_AR"
	export AS="$ANDROID_AS"
	export LD="$ANDROID_LD"
	export NM="$ANDROID_NM"
	export RANLIB="$ANDROID_RANLIB"

	cd $INSTALL_DIR/zlib-*
	./configure -u=Linux
	make -j16
	make install

	log_zlib_result
}

function move_zlib_output(){
	echo "$GLOBAL_INSTALL_DIR"
	if [ ! -z "$GLOBAL_INSTALL_DIR" ]; then
		mkdir -p $GLOBAL_INSTALL_DIR/include
		cp -rf $ZLIB_INSTALL_DIR/include/* $GLOBAL_INSTALL_DIR/include/
		ls $ZLIB_INSTALL_DIR/lib/*
		cp -rf $ZLIB_INSTALL_DIR/lib/* $GLOBAL_INSTALL_DIR/
	fi
}

function depend_zlib(){

	echo -ne "\x1B[01;32m"
	echo "--------------------------------------------------------"
	echo "|                      ZLIB TASK                       |"
	echo "--------------------------------------------------------"
	echo -ne "\x1B[0m"

	define_zlib_install_directory
	get_zlib
	log_zlib_header
	build_zlib
	move_zlib_output
}
