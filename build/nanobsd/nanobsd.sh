#!/bin/sh
#
# Copyright (c) 2005 Poul-Henning Kamp.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
# $FreeBSD: head/tools/tools/nanobsd/nanobsd.sh 222535 2011-05-31 17:14:06Z imp $
#

set -e

. $(dirname "$0")/nanobsd_funcs.sh

usage () {
	cat >&2 <<EOF
usage: ${0##*/} [-biknqvw] [-c config_file]
	-b		suppress builds (both kernel and world)
	-c config_file	config file to use after defining all
			internal variables.
	-i		suppress disk image build
	-j make-jobs	number of make jobs to invoke
	-k		suppress buildkernel
	-n		add -DNO_CLEAN to buildworld, buildkernel, etc
	-q		make output more quiet
	-v		make output more verbose
	-w		suppress buildworld
EOF
	exit 2
}

#######################################################################
# Parse arguments

set +e

do_kernel=true
do_world=true
do_image=true
do_copyout_partition=true
make_jobs=3
nano_confs=

while getopts 'bc:fhij:knqvw' optch
do
	case "$optch" in
	b)
		do_world=false
		do_kernel=false
		;;
	c)
		if [ -f "$OPTARG" ]; then
			nano_confs="$nano_confs $OPTARG"
		fi
		;;
	f)
		do_copyout_partition=false
		;;
	h)
		usage
		;;
	i)
		do_image=false
		;;
	j)
		echo $OPTARG | egrep -q '^[[:digit:]]+$' && [ $OPTARG -gt 0 ]
		if [ $? -ne 0 ]; then
			echo "${0##*/}: -j value must be a positive integer."
			usage
		fi
		make_jobs=$OPTARG
		;;
	k)
		do_kernel=false
		;;
	q)
		: $(( PPLEVEL -= 1))
		;;
	v)
		: $(( PPLEVEL += 1))
		;;
	w)
		do_world=false
		;;
	*)
		usage
		;;
	esac
done

shift $(( $OPTIND - 1 ))

if [ $# -gt 0 ] ; then
	echo "${0##*/}: extraneous arguments supplied"
	usage
fi

setup_and_export_internal_variables

NANO_PMAKE="$NANO_PMAKE -j $make_jobs"

set -e

#######################################################################
# And then it is as simple as that...

# File descriptor 3 is used for logging output, see pprint
exec 3>&1

NANO_STARTTIME=`date +%s`
pprint 1 "NanoBSD image ${NANO_NAME} build starting"

trap on_exit EXIT

if $do_world ; then
	mkdir -p ${MAKEOBJDIRPREFIX}
	printenv > ${MAKEOBJDIRPREFIX}/_.env
	make_conf_build
	build_world
else
	pprint 2 "Skipping buildworld (as instructed)"
fi

if $do_kernel ; then
	if ! $do_world ; then
		make_conf_build
	fi
	build_kernel
else
	pprint 2 "Skipping buildkernel (as instructed)"
fi

if [ -e "${NANO_WORLDDIR}" ]; then
	 rm -fr "${NANO_WORLDDIR}" || true
fi
mkdir -p ${NANO_OBJ} ${NANO_WORLDDIR}
printenv > ${NANO_OBJ}/_.env
make_conf_install
install_world
install_etc
setup_nanobsd_etc
install_kernel

run_customize
setup_nanobsd
prune_usr
run_late_customize
# SEF
# Build packages here.

set -x
TOOLDIR=${NANO_OBJ}/_.pkgtools
mkdir -p ${TOOLDIR}
rm -rf ${NANO_OBJ}/_.packages
mkdir -p ${NANO_OBJ}/_.packages/Packages
make -C ${AVATAR_ROOT}/src/freenas-pkgtools obj
make -C ${AVATAR_ROOT}/src/freenas-pkgtools all
make -C ${AVATAR_ROOT}/src/freenas-pkgtools install BINDIR=${TOOLDIR}/usr/local/bin \
    LIBDIR=${TOOLDIR}/usr/local/lib/freenasOS
make -C ${AVATAR_ROOT}/src/freenas-pkgtools package BINDIR=${TOOLDIR}/usr/local/bin \
    LIBDIR=${TOOLDIR}/usr/local/lib/freenasOS PACKAGE_DIR=${NANO_OBJ}/_.packages/Packages
# Now we should have some package tools and even a package.
if [ -f ${TOOLDIR}/usr/local/bin/create_package ]; then
    ${TOOLDIR}/usr/local/bin/create_package -R "${NANO_WORLDDIR}" -T build/Templates/freenas -V ${VERSION}-${REVISION:-0} ${NANO_OBJ}/_.packages/Packages/freenas-${VERSION}-${REVISION:-0}.tgz
    ${TOOLDIR}/usr/local/bin/create_package -R "${NANO_WORLDDIR}" -T build/Templates/freenasUI -V ${VERSION}-${REVISION:-0} ${NANO_OBJ}/_.packages/Packages/freenasUI-${VERSION}-${REVISION:-0}.tgz
    if [ -n "${SEQUENCE}" ]; then
	seq_arg="-S ${SEQUENCE}"
    else
	seq_arg=""
    fi
    env PYTHONPATH="${TOOLDIR}/usr/local/lib" ${TOOLDIR}/usr/local/bin/create_manifest -P ${NANO_OBJ}/_.packages -o ${NANO_OBJ}/_.packages/FreeNAS-${SEQUENCE:-0} -R FreeNAS-${VERSION} ${seq_arg} -T ${TRAIN:-FreeNAS} freenas=${VERSION}-${REVISION:-0} freenasUI=${VERSION}-${REVISION:-0} freenas-pkg-tools=${VERSION}-${REVISION:-0}
    ln -sf FreeNAS-${SEQUENCE:-0} ${NANO_OBJ}/_.packages/FreeNAS-MANIFEST
else
    echo "What happened to the tools?!?!?!"
    false
fi
set +x

last_orders

pprint 1 "NanoBSD stuff ${NANO_NAME} completed"
