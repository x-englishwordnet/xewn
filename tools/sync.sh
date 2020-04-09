#!/bin/bash

# C O L O R S

R='\u001b[31m'
G='\u001b[32m'
B='\u001b[34m'
Y='\u001b[33m'
M='\u001b[35m'
C='\u001b[36m'
Z='\u001b[0m'

# G I T

gitsource="https://github.com/globalwordnet/english-wordnet.git"
branch=2020-release-candidate

# D I R S

THISDIR=`dirname $(readlink -m "$0")`
source "${THISDIR}/home.sh"

# in
GITDIR=${HOMEDIR}/upstream

# F U N C T I O N S

function tag()
{
	echo "UPSTREAM:" 
	#git rev-parse HEAD
	git log -n 1
}

# M A I N

if false; then 																	# S T A R T _ C O N D I T I O N A L
echo "not executed"
fi																				# E N D _ C O N D I T I O N A L

# clone if needed
if [ -e "${GITDIR}" -a ! -d "${GITDIR}" ]; then
	echo -e "${R}${GITDIR} is not a dir${Z}"
	exit
fi
if [ ! -e "${GITDIR}" ]; then
	echo -e "${C}cloning ${GITDIR} ${Z}"
	pushd "${HOMEDIR}" > /dev/null
	pwd
	git clone "${gitsource}"
	mv "english-wordnet" upstream
	popd > /dev/null
fi

pushd "${GITDIR}" > /dev/null

# update
git pull
git checkout "${branch}"
git status

# tag
tag=`tag`
echo -e "${Y}'''"
echo -e "${tag}"
echo -e "'''${Z}"

echo "${tag}" > src/build

popd > /dev/null

# copy to source
read -p "Are you sure you want to copy build tag to src? " -n 1 -r
echo    # (optional) move to a new line
echo -e "${Z}"
if [[ $REPLY =~ ^[Yy]$ ]]; then
	pushd "${HOMEDIR}" > /dev/null
	cp -Rp "${GITDIR}/src" .
	popd > /dev/null
	echo -e "${G}sources updated${Z}"
fi

echo "done"

