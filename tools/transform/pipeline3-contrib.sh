#!/bin/bash

for f in $*; do
	./transform3.sh merge-lexentries3.xsl - $f |
	./transform3.sh add-sensekey.xsl - - |
	./transform3.sh add-tag_count.xsl - - |
	./transform3.sh add-adj_position.xsl - - |
	./transform3.sh add-verb_frame-decl.xsl - - |
	./transform3.sh add-verb_frame.xsl - - |
	./transform3.sh add-verb_frame-attr.xsl - - |
	./transform3.sh add-verb_template-decl.xsl - - |
	./transform3.sh add-verb_template-attr.xsl - - |
	./transform3.sh remove-syntacticbehaviourref.xsl - -
done
