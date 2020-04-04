#!/bin/bash

# D I R S

THISDIR=`dirname $(readlink -m "$0")`
source "${THISDIR}/tools/home.sh"

# out
XSRCDIR=${HOMEDIR}/xsrc
MERGEDDIR=${HOMEDIR}/merged
WNDBDIR=${HOMEDIR}/wndb
WNDBCOMPATDIR=${HOMEDIR}/wndb_compat

# M A I N

pushd "$TOOLSDIR" > /dev/null

mkdir -p "${XSRCDIR}"
mkdir -p "${MERGEDDIR}"
mkdir -p "${WNDBDIR}"
mkdir -p "${WNDBCOMPATDIR}"

./sync.sh
./make-data-xml.sh
./make-data-wndb.sh

pushd "$TOOLSDIR" > /dev/null

