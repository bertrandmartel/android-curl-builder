#!/bin/bash

function log_curl_result(){

	echo -ne "\x1B[01;32m"
	echo "-------------CURL CROSS COMPILED SUCCESSFULLY-----------"
	echo "| install directory : $CURL_INSTALL_DIR"
	echo "| headers directory : $CURL_INSTALL_DIR/usr/local/include"
	echo "| library directory : $CURL_INSTALL_DIR/usr/local/lib"
	echo "--------------------------------------------------------"
	echo -ne "\x1B[0m"
}

function log_curl_header(){

	echo -ne "\x1B[01;32m"
	echo "--------------------------------------------------------"
	echo "| CURL_INSTALL_DIR       : $CURL_INSTALL_DIR"
	echo "| CURL_SOURCE_DIR        : $CURL_SOURCE_DIR"
	echo "| CC                     : $CC"
	echo "| AR                     : $AR"
	echo "| AS                     : $AS"
	echo "| LD                     : $LD"
	echo "| NM                     : $NM"
	echo "| RANLIB                 : $RANLIB"
	echo "| DESTDIR                : $DESTDIR"
	echo "| CPPFLAGS               : $CPPFLAGS"
	echo "| LDFLAGS                : $LDFLAGS"
	echo "| LIBS                   : $LIBS"
	echo "| CROSS_COMPILE          : $CROSS_COMPILE"
	echo "--------------------------------------------------------"
	echo -ne "\x1B[0m"
}

function define_curl_install_directory(){

	echo -ne "\x1B[01;32m"
	echo "> set curl install directory ..."
	echo -ne "\x1B[0m"

	if [ -z "$CURL_INSTALL_DIR" ]; then
		CURL_INSTALL_DIR="$INSTALL_DIR/$CURL_DEFAULT_INSTALL_DIR"
		rm -rf $CURL_INSTALL_DIR
	fi
}

function get_curl(){
	
	if [ -z "$CURL_SOURCE_DIR" ]; then

		echo -ne "\x1B[01;32m"
		echo "> downloading curl ..."
		echo -ne "\x1B[0m"

		rm -rf $INSTALL_DIR/curl-curl-*
		wget -q --show-progress -P $INSTALL_DIR $CURL_TARBALL
		TAR_FILE=`echo "${CURL_TARBALL##*/}"`
		tar -xzf $INSTALL_DIR/$TAR_FILE -C $INSTALL_DIR
		rm $INSTALL_DIR/$TAR_FILE
	fi
}

function build_curl(){

	echo -ne "\x1B[01;32m"
	echo "> building curl ..."
	echo -ne "\x1B[0m"
	
	cd $CURRENT_DIR
	source config.sh

	cd $INSTALL_DIR/curl-curl-*

	export CC="$ANDROID_CC"
	export AR="$ANDROID_AR"
	export AS="$ANDROID_AS"
	export LD="$ANDROID_LD"
	export NM="$ANDROID_NM"
	export RANLIB="$ANDROID_RANLIB"

	export DESTDIR="$CURL_INSTALL_DIR"
	export CPPFLAGS="-I${OPENSSL_INSTALL_DIR}/include -I${ZLIB_INSTALL_DIR}/include" #path to zlib and openssl header folder
	export LDFLAGS="-L${OPENSSL_INSTALL_DIR}/lib -L${ZLIB_INSTALL_DIR}/lib" #path to zlib and openssl library folder
	export LIBS="-lssl -lcrypto"
	
	log_curl_header

	chmod 777 buildconf
	./buildconf
	./configure --host="${CROSS_COMPILE}" $CURL_ARGS

	make -j16
	make install

	log_curl_result
}

function move_curl_output(){
	if [ ! -z "$GLOBAL_INSTALL_DIR" ]; then
		mkdir -p $GLOBAL_INSTALL_DIR/include
		cp -rf $CURL_INSTALL_DIR/usr/local/include/* $GLOBAL_INSTALL_DIR/include/
		cp -rf $CURL_INSTALL_DIR/usr/local/lib/* $GLOBAL_INSTALL_DIR/
	fi
}

function depend_curl(){

	echo -ne "\x1B[01;32m"
	echo "--------------------------------------------------------"
	echo "|                      CURL TASK                       |"
	echo "--------------------------------------------------------"
	echo -ne "\x1B[0m"

	define_curl_install_directory
	get_curl
	build_curl
	move_curl_output
}