#!/bin/bash

for f in $*; do
	./transform3.sh add-sense_order.xsl - $f |
	./transform3.sh add-sensekey.xsl - - |
	./transform3.sh add-tag_count.xsl - -
done
