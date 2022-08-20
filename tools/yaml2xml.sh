#!/bin/bash

R='\u001b[31m'
G='\u001b[32m'
B='\u001b[34m'
Y='\u001b[33m'
M='\u001b[35m'
C='\u001b[36m'
Z='\u001b[0m'

# D I R S

THISDIR=`dirname $(readlink -m "$0")`
UPSTREAMDIR=upstream
XMLDIR=src/xml

# M A I N

echo -e "${C}* Convert YAML to XML${Z}"
pushd "../${UPSTREAMDIR}" > /dev/null
python3 scripts/from-yaml.py
popd > /dev/null

pushd ".." > /dev/null
mv -f "${UPSTREAMDIR}/src/xml"/* "${XMLDIR}"
rmdir "${UPSTREAMDIR}/src/xml" > /dev/null
popd > /dev/null

