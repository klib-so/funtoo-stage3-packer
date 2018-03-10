#!/bin/bash

export BUILD_SYSTEMRESCUECD_FILE="systemrescuecd-x86-5.2.1.iso"
export BUILD_SYSTEMRESCUECD_REMOTE_HASH="d76d9444a73ce2127e489f54b0ce1cb9057ae470459dc3fb32e8c916f7cbfe2e"

export BUILD_STAGE3_FILE="stage3-latest.tar.xz"

export BUILD_BOX_NAME="funtoo-stage3"
export BUILD_GUEST_TYPE="Gentoo_64"
export BUILD_GUEST_CPUS="4"
export BUILD_GUEST_MEMORY="2048"

# x86-64bit/generic64 build (multilib)
#export BUILD_FUNTOO_DOWNLOADPATH="https://build.funtoo.org/funtoo-current/x86-64bit/generic_64"
#export BUILD_BOX_DESCRIPTION="Funtoo stage3 installation (x86-64bit, generic64)"
#export BUILD_OUTPUT_FILE="funtoo-x86_64-generic_64-stage3.box"

# pure64/generic64 build
export BUILD_FUNTOO_DOWNLOADPATH="https://build.funtoo.org/funtoo-current/pure64/generic_64-pure64"
export BUILD_BOX_DESCRIPTION="Funtoo stage3 installation (pure64, generic64)"
export BUILD_OUTPUT_FILE="funtoo-pure64-generic_64-stage3.box"

echo "Executing $0 ..."
echo "=== Build settings ============================================================="
env | grep BUILD_
echo "================================================================================"
