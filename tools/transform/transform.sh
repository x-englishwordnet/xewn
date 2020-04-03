#!/bin/bash

MEM=-Xmx1G

RED='\u001b[31m'
GREEN='\u001b[32m'
YELLOW='\u001b[33m'
BLUE='\u001b[34m'
MAGENTA='\u001b[35m'
CYAN='\u001b[36m'
RESET='\u001b[0m'

if [ -z "$1" ]; then
	echo "${RED}XSL: null${RESET}" 1>&2;
	exit
fi
XSL="$1"
shift
echo -e "${MAGENTA}XSL: $XSL${RESET}" 1>&2;

OUT="$1"
shift
echo -e "${MAGENTA}OUT: $OUT${RESET}" 1>&2;

ISDIR=
if [ "$1" == "-dir" ]; then
	shift
	ISDIR="-dir"
	echo -e "${MAGENTA}OUT: is directory${RESET}" 1>&2;
fi

if [ -z "$*" ]; then
	echo -e "${RED}SRC: null${RESET}" 1>&2;
	exit
fi
echo -e "${MAGENTA}SRC: $*${RESET}" 1>&2;
echo 1>&2;

java $MEM -jar transformer.jar $XSL $OUT $ISDIR $*
