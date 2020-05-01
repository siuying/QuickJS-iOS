#!/bin/sh

# directories
SOURCE="quickjs-2020-04-12"
SOURCE_URL="https://bellard.org/quickjs/quickjs-2020-04-12.tar.xz"
FAT="QuickJS_iOS"

THIN=`pwd`/"thin"

ARCHS="arm64 arm64e x86_64"
COMPILE="y"
LIPO="y"
DEPLOYMENT_TARGET="10.0"

if [ "$*" ]
then
	if [ "$*" = "lipo" ]
	then
		# skip compile
		COMPILE=
	else
		ARCHS="$*"
		if [ $# -eq 1 ]
		then
			# skip lipo
			LIPO=
		fi
	fi
fi

if [ "$COMPILE" ]
then
	if [ ! -r $SOURCE ]
	then
		echo 'QuickJS source not found. Trying to download...'
		curl $SOURCE_URL -o quickjs.tar.xz && tar -xf ./quickjs.tar.xz \
			|| exit 1
		ln -s $SOURCE/VERSION ./VERSION
	fi

	CWD=`pwd`
	for ARCH in $ARCHS
	do
		echo "building $ARCH..."

		CFLAGS="-arch $ARCH"
		if [ "$ARCH" = "i386" -o "$ARCH" = "x86_64" ]
		then
			CONFIG_XCRUN_EXTRA_FLAG="-sdk iphonesimulator"
		    CONFIG_EXTRA_CFLAGS="-arch $ARCH -mios-simulator-version-min=$DEPLOYMENT_TARGET"
		else
			CONFIG_XCRUN_EXTRA_FLAG="-sdk iphoneos"
			CONFIG_EXTRA_CFLAGS="-arch $ARCH -mios-simulator-version-min=$DEPLOYMENT_TARGET -fembed-bitcode"
		fi

		if [ "$ARCH" = "i386" -o "$ARCH" = "armv7" ]
		then
		    CONFIG_M32="y"
		fi

		TMPDIR=${TMPDIR/%\/} CONFIG_M32=${CONFIG_M32} CONFIG_EXTRA_CFLAGS=${CONFIG_EXTRA_CFLAGS} CONFIG_XCRUN_EXTRA_FLAG=${CONFIG_XCRUN_EXTRA_FLAG} make -f ../Makefile -C $CWD/$SOURCE clean libquickjs.a || exit 1
		mkdir -p $THIN/$ARCH/lib
		mv $CWD/$SOURCE/libquickjs.a $THIN/$ARCH/lib/libquickjs.a
		cd $CWD
	done
fi

if [ "$LIPO" ]
then
	echo "building fat binaries..."
	mkdir -p $FAT/lib
	set - $ARCHS
	CWD=`pwd`
	cd $THIN/$1/lib
	for LIB in *.a
	do
		cd $CWD
		echo lipo -create `find $THIN -name $LIB` -output $FAT/lib/$LIB 1>&2
		lipo -create `find $THIN -name $LIB` -output $FAT/lib/$LIB || exit 1
	done

	cd $CWD
	cp $CWD/$SOURCE/quickjs*.h $FAT
fi

echo Done
