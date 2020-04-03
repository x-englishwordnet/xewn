#/bin/bash

for f in $*; do
	echo $f; 
	xmllint $f > ${f}.2; 
done
