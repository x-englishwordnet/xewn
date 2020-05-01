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

XSL=merge-lexfiles.xsl
echo -e "${M}XSL: $XSL${Z}" 1>&2;

DIR="$1"
if [ -z "$DIR" ]; then
	DIR=.
fi
echo -e "${M}DIR: $DIR${Z}" 1>&2;

OUT="$2"
if [ ! -z "$OUT" ]; then
	echo -e "${M}OUT: $OUT${Z}" 1>&2;
	OUT="-o:$OUT"
fi

java -jar Saxon-HE-9.9.1-6.jar $OPTIONS -s:source.xml $OUT -xsl:"$XSL" dir="$DIR"
