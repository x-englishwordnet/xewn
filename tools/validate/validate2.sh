#!/bin/bash

MEM=-Xmx2G

RED='\u001b[31m'
GREEN='\u001b[32m'
YELLOW='\u001b[33m'
BLUE='\u001b[34m'
MAGENTA='\u001b[35m'
CYAN='\u001b[36m'
RESET='\u001b[0m'

XSD="$1"
DATA="$2"
ISDIR="$3"

echo -e "${MAGENTA}XSD: $XSD${RESET}" 1>&2;

if [ "$ISDIR" == "-dir"  ]; then
	shift # consume XSD
	shift # consume dir
	shift # consume -dir
	DIR="$DATA"
	echo -e "${MAGENTA}DIR: $DIR${RESET}" 1>&2;
	java -jar validator2-runnable.jar "$XSD" $DIR/*.xml $*
else
	shift # consume XSD
	echo -e "${MAGENTA}XML: $*${RESET}" 1>&2;
	java -jar validator2-runnable.jar "$XSD" $*
fi
