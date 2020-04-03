#!/bin/bash

MEM=-Xmx2G
OPTIONS=

RED='\u001b[31m'
GREEN='\u001b[32m'
YELLOW='\u001b[33m'
BLUE='\u001b[34m'
MAGENTA='\u001b[35m'
CYAN='\u001b[36m'
RESET='\u001b[0m'

XSL=merge-lexfiles.xsl
echo -e "${MAGENTA}XSL: $XSL${RESET}" 1>&2;

DIR="$1"
if [ -z "$DIR" ]; then
	DIR=.
fi
echo -e "${MAGENTA}DIR: $DIR${RESET}" 1>&2;

OUT="$2"
if [ ! -z "$OUT" ]; then
	echo -e "${MAGENTA}OUT: $OUT${RESET}" 1>&2;
	OUT="-o:$OUT"
fi

java -jar Saxon-HE-9.9.1-6.jar $OPTIONS -s:source.xml "$OUT" -xsl:"$XSL" dir="$DIR"
