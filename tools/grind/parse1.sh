#!/bin/bash

# env variables
# WNHOME20
# WNHOME21
# WNHOME30
# WNHOME31
# WNHOMEXX

# example: ./parse1.sh $WNHOME31 verb 1740

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

# noun|verb|adj|adv
POS=$2
case $POS in
	n) POS=noun ;;
	v) POS=verb ;;
	a) POS=adj ;;
	s) POS=adj ;;
	r) POS=adv ;;
esac

# offset (ie 1740)
OFS=$3

echo "${INDIR}"
java -cp oewn-parse_wndb.jar org.oewntk.parse.DataParser1 "${INDIR}" ${POS} "${OFS}"
