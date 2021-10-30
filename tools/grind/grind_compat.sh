#!/bin/bash

COMPAT_POINTER="-compat:pointer"
COMPAT_LEXID="-compat:lexid"
COMPAT_LEXID=
COMPAT_VERBFRAME="-compat:verbframe"

IN="$1"
if [ -z "$1" ]; then
	IN=merged.xml
fi
echo "XML: $IN" 1>&2;

OUTDIR="$2"
if [ -z "$2" ]; then
	OUTDIR=.
fi
echo "DIR: $OUTDIR" 1>&2;

java -ea -jar ewn-grind.jar ${COMPAT_POINTER} ${COMPAT_LEXID} ${COMPAT_VERBFRAME} "${IN}" "${OUTDIR}"
