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
source ${THISDIR}/home.sh

# in
SRCDIR=${HOMEDIR}/src/xml

# out
#XSRCDIR=${HOMEDIR}/xsrc
MERGEDDIR=${HOMEDIR}/merged
WNDBDIR=${HOMEDIR}/wndb
WNDBCOMPATDIR=${HOMEDIR}/wndb_compat
#mkdir -p "${XSRCDIR}"
mkdir -p "${MERGEDDIR}"
mkdir -p "${WNDBDIR}"
mkdir -p "${WNDBCOMPATDIR}"
MERGED=${MERGEDDIR}/xewn.xml

# tools
TRANSFORMERDIR="${TOOLSDIR}/transform"
MERGERDIR="${TOOLSDIR}/merge"
VALIDATORDIR="${TOOLSDIR}/validate"

# M A I N

if false; then 																	# S T A R T _ C O N D I T I O N A L
echo "not executed"
fi																				# E N D _ C O N D I T I O N A L

echo -e "${CYAN}X M L${Z}"

# PRE-TRANSFORM VALIDATE
echo -e "${C}* Validate src XML${Z}"
pushd ${VALIDATORDIR} > /dev/null
./validate2.sh 1.1b/EWN-LMF-1.1-relax_idrefs.xsd "$SRCDIR" -dir
popd > /dev/null

# TRANSFORM
echo -e "${C}* Transform XMLs${Z}"
pushd ${TRANSFORMERDIR} > /dev/null
echo 'none'
#./pipeline3-all.sh "$SRCDIR" "${XSRCDIR}"
popd > /dev/null

# MERGE
echo -e "${C}* Merge XML${Z}"
pushd ${MERGERDIR} > /dev/null
./merge.sh "${SRCDIR}" $MERGED
popd > /dev/null

# VALIDATE
echo -e "${C}* Validate merged XML${Z}"
pushd ${VALIDATORDIR} > /dev/null
./validate2.sh 1.1b/EWN-LMF-1.1.xsd $MERGED

popd > /dev/null

# build stamp
#cp -p ${HOMEDIR}/src/build ${XSRCDIR}/
cp -p ${HOMEDIR}/src/build ${MERGEDDIR}/

echo "done"

