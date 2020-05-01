#!/bin/bash

MEM=-Xmx2G
OPTIONS=

R='\u001b[31m'
G='\u001b[32m'
B='\u001b[34m'
Y='\u001b[33m'
M='\u001b[35m'
C='\u001b[36m'
Z='\u001b[0m'

XSL=merge-main-xdata.xsl
echo -e "${M}XSL: $XSL${Z}" 1>&2;

MAIN="$1"
if [ -z "$MAIN" ]; then
	MAIN=wn.xml
fi
echo -e "${M}MAIN: $MAIN${Z}" 1>&2;

XDATA="$2"
if [ -z "$XDATA" ]; then
	XDATA=xdata.xml
fi
echo -e "${M}XDATA: $XDATA${Z}" 1>&2;

OUT="$3"
if [ ! -z "$OUT" ]; then
	echo -e "${M}OUT: $OUT${Z}" 1>&2;
	OUT="-o:$OUT"
fi

java -jar Saxon-HE-9.9.1-6.jar $OPTIONS -s:"$MAIN" $OUT -xsl:"$XSL" xdata="$XDATA"

