#!/bin/bash

MEM=-Xmx2G

R='\u001b[31m'
G='\u001b[32m'
B='\u001b[34m'
Y='\u001b[33m'
M='\u001b[35m'
C='\u001b[36m'
Z='\u001b[0m'

#DEF_XPATH="//Synset/@id"
DEF_XPATH="$1"
shift

#REF_XPATH="//SynsetRelation[@relType='hypernym']/@target"
REF_XPATH="$1"
shift

echo -e "${C}DEF:  $DEF_XPATH${Z}" 1>&2;
echo -e "${C}REF:  $REF_XPATH${Z}" 1>&2;
echo -e "${M}ARGS: $*${Z}" 1>&2;
java -cp validator2-runnable.jar validator.IDREFValidator "$DEF_XPATH" "$REF_XPATH" $*
