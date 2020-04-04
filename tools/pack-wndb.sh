#/bin/bash

# C O L O R S

R='\u001b[31m'
G='\u001b[32m'
B='\u001b[34m'
Y='\u001b[33m'
M='\u001b[35m'
C='\u001b[36m'
Z='\u001b[0m'

# D I R S

THISDIR=`dirname $(readlink -m "$0")`
source "${THISDIR}/home.sh"

DISTDIR=${HOMEDIR}/dist
mkdir -p ${DISTDIR}
DATADIR=${HOMEDIR}
echo "pack to ${DISTDIR} from ${DATADIR}"

# A R C H I V E S

TAR_ARCHIVE=${DISTDIR}/xewn.dict.tar.gz
ZIP_ARCHIVE=${DISTDIR}/xewn.zip
TAR_ARCHIVE_COMPAT=${DISTDIR}/xewn_compat.dict.tar.gz
ZIP_ARCHIVE_COMPAT=${DISTDIR}/xewn_compat.zip

# M A I N

if [ ! -e "${DATADIR}/wndb" -a ! -d "${DATADIR}/wndb" ]; then
	echo -e "${R}Non existent wndb dir${Z}"
	exit 1
fi
pushd ${DATADIR} > /dev/null
ln -sfT wndb/ dict
popd > /dev/null

echo -e "${M}pack to `basename ${TAR_ARCHIVE}`${Z}"
rm -f ${TAR_ARCHIVE}
tar czfh ${TAR_ARCHIVE} -C ${DATADIR} dict -C ${DATADIR} LICENSE.md
echo -e "${C}"
tar tvf ${TAR_ARCHIVE}
echo -e "${Z}"
echo -e "${G}${TAR_ARCHIVE}${Z}"

echo -e "${M}pack to `basename ${ZIP_ARCHIVE}`${Z}"
rm -f ${ZIP_ARCHIVE}
zip -j ${ZIP_ARCHIVE} ${DATADIR}/dict/*
echo -e "${C}"
unzip -l ${ZIP_ARCHIVE}
echo -e "${Z}"
echo -e "${G}${ZIP_ARCHIVE}${Z}"

if [ ! -e "${DATADIR}/wndb_compat" -a ! -d "${DATADIR}/wndb_compat" ]; then
	echo -e "${R}Non existent wndb_compat dir${Z}"
	exit 1
fi
pushd ${DATADIR} > /dev/null
ln -sfT wndb_compat/ dict
popd > /dev/null

echo -e "${M}pack to `basename ${TAR_ARCHIVE_COMPAT}`${Z}"
rm -f ${TAR_ARCHIVE_COMPAT}
tar czfh ${TAR_ARCHIVE_COMPAT} -C ${DATADIR} dict -C ${DATADIR} LICENSE.md
echo -e "${C}"
tar tvf ${TAR_ARCHIVE_COMPAT}
echo -e "${Z}"
echo -e "${G}${TAR_ARCHIVE_COMPAT}${Z}"

echo -e "${M}pack to `basename ${ZIP_ARCHIVE_COMPAT}`${Z}"
rm -f ${ZIP_ARCHIVE_COMPAT}
zip -j ${ZIP_ARCHIVE_COMPAT} ${DATADIR}/dict/*
echo -e "${C}"
unzip -l ${ZIP_ARCHIVE_COMPAT}
echo -e "${Z}"
echo -e "${G}${ZIP_ARCHIVE_COMPAT}${Z}"

rm ${DATADIR}/dict

