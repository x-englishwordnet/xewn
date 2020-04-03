#!/bin/bash

RED='\u001b[31m'
GREEN='\u001b[32m'
YELLOW='\u001b[33m'
BLUE='\u001b[34m'
MAGENTA='\u001b[35m'
CYAN='\u001b[36m'
RESET='\u001b[0m'

declare -A versions=( 
["1.1"]="	1.1		src				WN-LMF-1.1-relax_idrefs		EWN-LMF-1.1-relax_idrefs" 
["1.1m"]="	1.1		src_merged		WN-LMF-1.1	 				EWN-LMF-1.1" 

["2.0"]="	2.0		src2			WN-LMF-2.0-relax_idrefs		EWN-LMF-2.0-relax_idrefs"
["2.0m"]="	2.0		src2_merged		WN-LMF-2.0	 				EWN-LMF-2.0"

["1.10"]="	1.10	xsrc			xWN-LMF-1.10-relax_idrefs	xEWN-LMF-1.10-relax_idrefs" 
["1.10m"]="	1.10	xsrc_merged		xWN-LMF-1.10 				xEWN-LMF-1.10" 


["2.10"]="	2.10	xsrc2			xWN-LMF-2.10-relax_idrefs	xEWN-LMF-2.10-relax_idrefs"
#["2.10m"]="	2.10	xsrc2_merged	xWN-LMF-2.10	 			xEWN-LMF-2.10"
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
		#echo "./validate.sh ${v}/${f}.xsd ${d}/*.xml"
		./validate2.sh ${v}/${f}.xsd in/${d}/*.xml
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

