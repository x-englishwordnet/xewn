#!/bin/bash

for f in $*; do
	./transform.sh add-sense_order.xsl - $f |
	./transform.sh add-sensekey.xsl - - |
	./transform.sh add-tag_count.xsl - -
done
