#!/bin/sh
#
# k2hftfuse for file transaction by FUSE-based file system
#
# Copyright 2015 Yahoo! JAPAN corporation.
#
# k2hftfuse is file transaction system on FUSE file system with
# K2HASH and K2HASH TRANSACTION PLUGIN, CHMPX.
#
# For the full copyright and license information, please view
# the LICENSE file that was distributed with this source code.
#
# AUTHOR:   Takeshi Nakatani
# CREATE:   Tue Sep 1 2015
# REVISION:
#

#
# This script puts git commit hash string to C header file.
# ex: static const char version[] = "....";
#
# Usage: make_rev.sh <filename> <valuename>
#

PRGNAME=`basename $0`

if [ $# -ne 2 ]; then
	echo "${PRGNAME}: Error - parameter is not found."
	exit 1
fi
FILEPATH=$1
VALUENAME=$2

REVISION=`git rev-parse --short HEAD`
if [ $? -ne 0 ]; then
	echo "${PRGNAME}: Warning - git commit hash code is not found, so set to \"unknown\"."
	REVISION="unknown"
fi
#echo ${REVISION}

NEWCODES="char ${VALUENAME}[] = \"${REVISION}\";"
#echo ${NEWCODES}

if [ -f ${FILEPATH} ]; then
	FILECODES=`cat ${FILEPATH}`
	#echo ${FILECODES}

	if [ "X${FILECODES}" = "X${NEWCODES}" ]; then
		#echo "${PRGNAME}: ${FILEPATH} is not updated."
		exit 0
	fi
fi

echo ${NEWCODES} > ${FILEPATH}
echo "${PRGNAME}: ${FILEPATH} is updated."

exit 0

#
# VIM modelines
#
# vim:set ts=4 fenc=utf-8:
#
