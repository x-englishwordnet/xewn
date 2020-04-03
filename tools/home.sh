#!/bin/bash

B='\u001b[34m'
Z='\u001b[0m'
D='\u001b[90m'

# DATA
THISDIR="`dirname $(readlink -m $0)`"
THISDIR="$(readlink -m ${THISDIR})"

# dirs
export HOMEDIR="$(readlink -m $THISDIR/..)"
export TOOLSDIR="$HOMEDIR/tools"

echo -e "${B}
 HOMEDIR ${D}${HOMEDIR}${B}
 ├─ upstream (in)
 │  ├─ src
 │
 ├─ xsrc (out)
 ├─ merged (out)
 ├─ wndb (out)
 ├─ wndb_compat (out)
 │
 ├─ tools ${D}${TOOLSDIR}${B}
 │  ├─ transform
 │  ├─ merge
 │  ├─ validate
 │  └─ grind
${Z}"

