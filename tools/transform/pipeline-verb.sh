#!/bin/bash

for f in $*; do
	./transform.sh add-sensekey.xsl - $f |
	./transform.sh add-tag_count.xsl - - |
	./transform.sh add-verb_frame-decl.xsl - - |
	./transform.sh add-verb_frame.xsl - - |
	./transform.sh add-verb_frame-attr.xsl - - |
	./transform.sh add-verb_template-decl.xsl - - |
	./transform.sh add-verb_template-attr.xsl - - |
	./transform.sh remove-syntacticbehaviourref.xsl - - 
done
