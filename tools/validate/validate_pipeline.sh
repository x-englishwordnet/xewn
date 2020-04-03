#!/bin/bash

RED='\u001b[31m'
GREEN='\u001b[32m'
YELLOW='\u001b[33m'
BLUE='\u001b[34m'
MAGENTA='\u001b[35m'
CYAN='\u001b[36m'
RESET='\u001b[0m'

XSDDIR="1.10pipe"

declare -A versions=( 
["orig"]="		1.1		src						EWN-LMF-1.1-relax_idrefs" 
["sk"]="		1.2		pipe1_sk					xEWN-LMF-1.2-relax_idrefs" 
["tagcnt"]="	1.2		pipe2_tagcount				xEWN-LMF-1.2-relax_idrefs" 
["adjpos"]="	1.3		pipe3_adjposition			xEWN-LMF-1.3-relax_idrefs" 
["vfdecl"]="	1.3.1	pipe31_verbframe_decl		xEWN-LMF-1.3.1-relax_idrefs" 
["vf"]="		1.3.2	pipe32_verbframe			xEWN-LMF-1.3.2-relax_idrefs" 
["vfattr"]="	1.3.3	pipe33_verbframe_attr		xEWN-LMF-1.3.3-relax_idrefs" 
["vtdecl"]="	1.3.4	pipe34_verbtemplate_decl	xEWN-LMF-1.3.4-relax_idrefs" 
["vtattr"]="	1.3.5	pipe35_verbtemplate_attr	xEWN-LMF-1.3.5-relax_idrefs" 
["nosb"]="		1.3.6	pipe36_sb					xEWN-LMF-1.3.6-relax_idrefs" 
["final"]="		1.10	xsrc						xEWN-LMF-1.10-relax_idrefs" 
["finalm"]="	1.10	xsrc_merged					xEWN-LMF-1.10" 
)

function process()
{
	local v=$1
	#echo ${v}
	shift
	local d=$1
	#echo ${d}
	shift
	for f in $*; do
		echo -e "${CYAN}${f} - ${d}${RESET}";
		#echo "./validate.sh ${XSDDIR}/${f}.xsd ${d}/*.xml"
		./validate2.sh ${XSDDIR}/${f}.xsd in/${d}/*.xml
		retVal=$?
		if [ $retVal -ne 0 ]; then
			echo -e "${RED}ERROR ${retVal}${RESET}"
		else
			echo -e "${GREEN}OK${RESET}"
		fi
		echo
	done
}

if [ ! -z "$*" ]; then
	for v in $*; do 
		echo -e "${BLUE}${v}${RESET}"
		process ${versions[$v]}
	done
	exit
fi

for v in "${!versions[@]}"; do 
	echo -e "${BLUE}${v}${RESET}"
	process ${versions[$v]}
done

