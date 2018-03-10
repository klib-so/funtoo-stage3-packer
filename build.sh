#!/bin/bash -e

. config.sh

command -v packer >/dev/null 2>&1 || { echo "Command 'packer' required but it's not installed.  Aborting." >&2; exit 1; }
command -v wget >/dev/null 2>&1 || { echo "Command 'wget' required but it's not installed.  Aborting." >&2; exit 1; }
command -v sha256sum >/dev/null 2>&1 || { echo "Command 'sha256sum' required but it's not installed.  Aborting." >&2; exit 1; }

if [ -f "$BUILD_SYSTEMRESCUECD_FILE" ]
then
    echo "'$BUILD_SYSTEMRESCUECD_FILE' found. Skipping download ..."
else
    echo "'$BUILD_SYSTEMRESCUECD_FILE' NOT found. Starting download ..."
    wget --content-disposition "https://sourceforge.net/projects/systemrescuecd/files/sysresccd-x86/$BUILD_SYSTEMRESCUECD_FILE/download"
    if [ $? -ne 0 ]; then
    	echo "Could not download '$BUILD_SYSTEMRESCUECD_FILE'. Exit code from wget was $?."
    	exit 1
    fi
fi

BUILD_SYSTEMRESCUECD_LOCAL_HASH=$(cat $BUILD_SYSTEMRESCUECD_FILE | sha256sum | grep -o '^\S\+')
if [ "$BUILD_SYSTEMRESCUECD_LOCAL_HASH" == "$BUILD_SYSTEMRESCUECD_REMOTE_HASH" ]
then
    echo "'$BUILD_SYSTEMRESCUECD_FILE' checksums matched. Proceeding ..."
else
    echo "'$BUILD_SYSTEMRESCUECD_FILE' checksum did NOT match with expected checksum. The file is possibly corrupted, please delete it and try again."
    exit 1
fi

BUILD_STAGE3_FILE_HASH="$BUILD_STAGE3_FILE.hash.txt"
BUILD_STAGE3_URL="$BUILD_FUNTOO_DOWNLOADPATH/$BUILD_STAGE3_FILE"
BUILD_STAGE3_HASH_URL="$BUILD_FUNTOO_DOWNLOADPATH/$BUILD_STAGE3_FILE_HASH"

rm -f "$BUILD_STAGE3_FILE_HASH"
wget $BUILD_STAGE3_HASH_URL

if [ -f "$BUILD_STAGE3_FILE" ]
then
    echo "'$BUILD_STAGE3_FILE' exists. Skipping download ..."
else
    echo "'$BUILD_STAGE3_FILE' not found. Starting download ..."
    wget $BUILD_STAGE3_URL
    if [ $? -ne 0 ]; then
    	echo "Could not download '$BUILD_STAGE3_URL'. Exit code from wget was $?."
    	exit 1
    fi
fi

BUILD_STAGE3_LOCAL_HASH=$(cat $BUILD_STAGE3_FILE | sha256sum | grep -o '^\S\+')
BUILD_STAGE3_REMOTE_HASH=$(cat $BUILD_STAGE3_FILE_HASH | sed -e 's/^sha256\s//g')

if [ "$BUILD_STAGE3_LOCAL_HASH" == "$BUILD_STAGE3_REMOTE_HASH" ]
then
    echo "'$BUILD_STAGE3_FILE' checksums matched. Proceeding ..."
else
    echo "'$BUILD_STAGE3_FILE' checksums did NOT match. The file is possibly outdated or corrupted, please delete it and try again."
    exit 1
fi

cp $BUILD_STAGE3_FILE ./scripts

#export BUILD_SYSTEMRESCUECD_FILE
#export BUILD_SYSTEMRESCUECD_REMOTE_HASH
#
#export BUILD_STAGE3_FILE
#export BUILD_STAGE3_URL

PACKER_LOG_PATH="$PWD/packer.log"
PACKER_LOG="1"

packer build virtualbox.json
