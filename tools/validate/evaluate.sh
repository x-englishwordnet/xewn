#!/bin/bash

MEM=-Xmx2G

R='\u001b[31m'
G='\u001b[32m'
B='\u001b[34m'
Y='\u001b[33m'
M='\u001b[35m'
C='\u001b[36m'
Z='\u001b[0m'

echo -e "${M}ARGS: $*${Z}" 1>&2;
java -cp validator2-runnable.jar validator.XPathEvaluator "$@" 2> >(while read line; do echo -e "${R}${line}${Z}" >&2; done)

#./evaluate.sh -o "@target" -x "//SynsetRelation[@relType='hypernym']" in/src_contrib/wn-contrib.colloq.xml
#./evaluate.sh -o "../@id" -x "//SynsetRelation[@relType='hyponym']" in/src_contrib/wn-contrib.colloq.xml
#./evaluate.sh -o "concat(../@id,' calls ',./@target)" -x "//SynsetRelation[@relType!='hyponym' and @relType!='hypernym']" in/src_contrib/wn-contrib.plwn.xml
#./evaluate.sh -o "concat(name(..),' ',../@id,' has rel ',@relType,' that targets ',./@target)" -x "//SynsetRelation[@relType!='hyponym' and @relType!='hypernym']" in/src_contrib/wn-contrib.plwn.xml
#./evaluate.sh -o "concat(name(..),' ',../@id,' has rel ',@relType,' that targets ',@target,' local:',count(id(@target))>0)" -x "//SynsetRelation[@relType!='hyponym' and @relType!='hypernym']" in/src_contrib/wn-contrib.plwn.xml -v 1.1/EWN-LMF-1.1-relax_idrefs.xsd
#./evaluate.sh -o "concat(name(..),' ',../@id,' --',../Definition,'-- has rel ',@relType,' that targets ',@target,' exists:',count(id(@target))>0)" -x "//SynsetRelation[@relType!='hyponym' and @relType!='hypernym']" in/src_contrib/wn-contrib.plwn.xml -v 1.1/EWN-LMF-1.1-relax_idrefs.xsd
#./evaluate.sh -o "Lemma/@writtenForm" -x "//LexicalEntry" in/src_contrib/wn-contrib.plwn.xml
#./evaluate.sh --and -o "Lemma/@writtenForm" -x "//LexicalEntry[starts-with(Lemma/@writtenForm,'z')]" in/src_contrib/wn-contrib.plwn.xml
#./evaluate.sh --and -o "Lemma/@writtenForm" -x "//LexicalEntry[starts-with(Lemma/@writtenForm,'w')]" -x "//LexicalEntry[contains(Lemma/@writtenForm,'r')]" in/src_contrib/wn-contrib.plwn.xml
#./evaluate.sh --minus -o "Lemma/@writtenForm" -x "//LexicalEntry[starts-with(Lemma/@writtenForm,'w')]" -x "//LexicalEntry[contains(Lemma/@writtenForm,'r')]" -x "//LexicalEntry[contains(Lemma/@writtenForm,'i')]" in/src_contrib/wn-contrib.plwn.xml