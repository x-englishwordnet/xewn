#!/bin/bash

for f in $*; do
	./transform3.sh add-sense_order.xsl - $f |
	./transform3.sh add-sensekey3.xsl - - |
	./transform3.sh add-tag_count.xsl - - |
	#./transform3.sh add-verb_frame-decl.xsl - - |
	#./transform3.sh add-verb_frame.xsl - - |
	./transform3.sh add-verb_frame-attr.xsl - - |
	./transform3.sh add-verb_template-decl.xsl - - |
	./transform3.sh add-verb_template-attr.xsl - - 
	#| ./transform3.sh remove-syntacticbehaviourref.xsl - -
done
