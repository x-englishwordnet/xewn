#!/bin/bash

B='\u001b[34m'
Z='\u001b[0m'
D='\u001b[90m'

# DATA

#[[ $0 != $BASH_SOURCE ]] && echo "Script is being sourced" || echo "Script is being run"
if [ "$0" != "$BASH_SOURCE" ]; then
	THISDIR="`dirname $(readlink -m $BASH_SOURCE)`"
else
	THISDIR="`dirname $(readlink -m $0)`"
fi

# dirs
export TOOLSDIR="${THISDIR}"
export HOMEDIR=`readlink -m "${THISDIR}/.."`

if [ "-verbose" == "$1" ]; then
echo -e "${B}
 HOMEDIR ${D}${HOMEDIR}${B}
 ├─ upstream (in)
 │  ├─ src
 │
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
fi

