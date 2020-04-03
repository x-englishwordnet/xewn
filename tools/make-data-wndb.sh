#!/bin/bash

R='\u001b[31m'
G='\u001b[32m'
B='\u001b[34m'
Y='\u001b[33m'
M='\u001b[35m'
C='\u001b[36m'
Z='\u001b[0m'

# DIRS

THISDIR="`dirname $(readlink -m $0)`"
THISDIR="$(readlink -m ${THISDIR})"
source ${THISDIR}/home.sh

# tools
GRINDDIR="$TOOLSDIR/grind"
TRANSFORMERDIR="$TOOLSDIR/transform"

# in
MERGEDDIR=${HOMEDIR}/merged
MERGED="${MERGEDDIR}/xewn.xml"
XTRASDIR=${HOMEDIR}/dict_extras

# out
WNDBDIR=${HOMEDIR}/wndb
WNDBDIR_COMPAT=${HOMEDIR}/wndb_compat
declare -A dests
dests=([wndb]="${WNDBDIR}" [wndb_compat]="${WNDBDIR_COMPAT}")
declare -A execs
execs=([wndb]="grind.sh" [wndb_compat]="grind_compat.sh")

# M A I N

if true; then 																	# S T A R T _ C O N D I T I O N A L
echo
fi																				# E N D _ C O N D I T I O N A L

for k in ${!dests[@]}; do 

	wndbdir="${dests[${k}]}"
	exec="${execs[${k}]}"

	echo -e "${Y}W N D B ${k}${Z} ${wndbdir}"

	# dir
	mkdir -p "${wndbdir}"
	echo -e "${C}* Clean up${Z}"
	pushd "${wndbdir}" > /dev/null
	rm -f build
	rm -f data.*
	rm -f index.*
	rm -f *.exc
	rm -f *.exc
	rm -f sent*.vrb
	rm -f sensemap.txt
	rm -f cntlist
	rm -f cntlist.rev
	rm -f frames.vrb
	rm -f lexnames
	rm -f verb.Framestext
	popd > /dev/null

	# dir sents.vrb + sentidx.vrb + sensemap.txt
	pushd ${TRANSFORMERDIR} > /dev/null
	echo -e "${C}* Transform XMLs sents.vrb + sentidx.vrb${Z}"
	./transform.sh create-sent.vrb.xsl ${wndbdir}/sents.vrb ${MERGED}
	./transform.sh create-sentidx.vrb.xsl - ${MERGED} | sort > ${wndbdir}/sentidx.vrb
	echo -e "${C}* Transform XMLs sensemap${Z}"
	./transform.sh create-sensemap_txt.xsl ${wndbdir}/sensemap.txt ${MERGED}
	popd > /dev/null

	# grind
	pushd "${GRINDDIR}" > /dev/null
	echo -e "${C}* Grind XML${Z}"
	echo -e "${C}  from: ${MERGED}${Z}"
	echo -e "${C}  to:   ${wndbdir}${Z}"
	cl="./${exec} ${option} \"${MERGED}\" \"${wndbdir}\""
	#echo $cl
	eval $cl

	# add standard files
	cp -p ${XTRASDIR}/* ${wndbdir}

	# parse
	echo -e "${C}* Parse${Z}"
	echo -e "${C}  from:   ${wndbdir}${Z}"
	./parse.sh "${wndbdir}"
	popd > /dev/null

	# build stamp
	cp -p ${MERGEDDIR}/build ${wndbdir}/

done

echo "done"

