#!/bin/bash

for f in $*; do
	./transform.sh add-sense_order.xsl - $f |
	./transform.sh add-adj_head.xsl - - |
	./transform.sh add-sensekey.xsl - - |
	./transform3.sh add-legacy_sensekey.xsl - - |
	./transform.sh add-tag_count.xsl - - #|
	#./transform.sh add-adj_position.xsl - -
done
