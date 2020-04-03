#!/bin/bash

# parse1.sh [WNDBDIR] [SYNSETID]
# parse1.sh [WNDBDIR] -sense [SENSEID]
# parse1.sh [WNDBDIR] -offset [POS] [OFS]

# 1=input XML file
IN=$1

# 2 SYNSETID | -sense | -offset

# 3 SENSEID | POS (n|v|a|r|s)

# 4 OFFSET (ie 1740)

java -cp ewn-grind.jar org.ewn.grind.Grinder1 "${IN}" $2 $3 $4 
