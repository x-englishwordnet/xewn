#!/bin/bash

# DIRS
THISDIR="`dirname $(readlink -m $0)`"
THISDIR="$(readlink -m ${THISDIR})"
HOMEDIR="$(readlink -m $THISDIR)"
TOOLSDIR="$HOMEDIR/tools"
echo "HOMEDIR:  $HOMEDIR"
echo "TOOLSDIR: $TOOLSDIR"

# out
XSRCDIR=$HOMEDIR/xsrc
MERGEDDIR=$HOMEDIR/merged
WNDBDIR=$HOMEDIR/wndb
WNDBCOMPATDIR=$HOMEDIR/wndb_compat
mkdir -p "$XSRCDIR"
mkdir -p "$MERGEDDIR"
mkdir -p "$WNDBDIR"
mkdir -p "$WNDBCOMPATDIR"

# M A I N

pushd "$TOOLSDIR" > /dev/null

./home.sh
./sync.sh
./make-data-xml.sh
./make-data-wndb.sh

pushd "$TOOLSDIR" > /dev/null

