#!/bin/bash

# parse1.sh [XML] [SYNSETID]
# ex: ./grind1.sh /opt/data/nlp/wordnet/WordNet-XX/BUILD/merged/xewn.xml ewn-02336471-n

# parse1.sh [XML] -sense [SENSEID]
# ex: ./grind1.sh /opt/data/nlp/wordnet/WordNet-XX/BUILD/merged/xewn.xml -sense ewn-sewer_rat-n-02336471-01

# parse1.sh [XML] -offset [POS] [OFS]
# ex: ./grind1.sh /opt/data/nlp/wordnet/WordNet-XX/BUILD/merged/xewn.xml -offset a 1740

# 1=input XML file
IN=$1

# 2				3				4
# SYNSETID
# -sense		SENSEID
# -offset		(n|v|a|r|s)		OFFSET

java -ea -cp ewn-grind.jar org.ewn.grind.Grinder1 "${IN}" $2 $3 $4
