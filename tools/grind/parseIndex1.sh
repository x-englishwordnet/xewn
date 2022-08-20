#!/bin/bash

# env variables
# WNHOME20
# WNHOME21
# WNHOME30
# WNHOME31
# WNHOMEXX

# example: ./parseIndex1.sh $WNHOME31 adj critical

INDIR="$1"
if [[ "${INDIR}" =~ ^[[:digit:]] ]]; then
	case ${INDIR} in
		20) INDIR="${WNHOME20}" ;;
		21) INDIR="${WNHOME21}" ;;
		30) INDIR="${WNHOME30}" ;;
		31) INDIR="${WNHOME31}" ;;
		00) INDIR="${WNHOMEXX}" ;;
	esac
else
	if [ -z "${INDIR}" ]; then
		INDIR=out
	fi
fi

echo "${INDIR}"
java -cp oewn-parse_wndb.jar org.oewntk.parse.IndexParser1 "${INDIR}" "$2" "$3"
