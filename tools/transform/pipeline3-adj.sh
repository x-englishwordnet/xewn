#!/bin/bash

for f in $*; do
	./transform3.sh merge-lexentries3.xsl - $f |
	./transform3.sh add-sensekey.xsl - - |
	./transform3.sh add-tag_count.xsl - - |
	./transform3.sh add-adj_position.xsl - -
done
