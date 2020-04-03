#!/bin/bash

# add-sensekey.xsl 				(n,v,a,r)
#	lib-lexid.xsl
#	lib-sensekey.xsl
#		lib-lexid.xsl
#		lib-satellite_head.xsl
#			lib-lexid.xsl
# add-verb_frames_decl.xsl	 	(v)
# add-verb_frames.xsl 			(v)
# add-verb_frames-attr.xsl 		(v)
# add-verb_templates_decl.xsl	(v)
# add-verb_templates.xsl 		(v)
# add-adj_position.xsl 			(a)

RED='\u001b[31m'
GREEN='\u001b[32m'
YELLOW='\u001b[33m'
BLUE='\u001b[34m'
MAGENTA='\u001b[35m'
CYAN='\u001b[36m'
RESET='\u001b[0m'

FROMDIR=$1
if [ -z "$FROMDIR" ] ; then
	FROMDIR=in/lexfiles
fi
echo "PIPE IN:  $FROMDIR" 1>&2;

TODIR=$2
if [ -z "$TODIR" ] ; then
	TODIR=out/lexfiles2
fi
echo "PIPE OUT: $TODIR" 1>&2;

adj="
wn-adj.all.xml
wn-adj.pert.xml
wn-adj.ppl.xml
"

adv="
wn-adv.all.xml
"

noun="
wn-noun.act.xml
wn-noun.animal.xml
wn-noun.artifact.xml
wn-noun.attribute.xml
wn-noun.body.xml
wn-noun.cognition.xml
wn-noun.communication.xml
wn-noun.event.xml
wn-noun.feeling.xml
wn-noun.food.xml
wn-noun.group.xml
wn-noun.location.xml
wn-noun.motive.xml
wn-noun.object.xml
wn-noun.person.xml
wn-noun.phenomenon.xml
wn-noun.plant.xml
wn-noun.possession.xml
wn-noun.process.xml
wn-noun.quantity.xml
wn-noun.relation.xml
wn-noun.shape.xml
wn-noun.state.xml
wn-noun.substance.xml
wn-noun.time.xml
wn-noun.Tops.xml
"

verb="
wn-verb.body.xml
wn-verb.change.xml
wn-verb.cognition.xml
wn-verb.communication.xml
wn-verb.competition.xml
wn-verb.consumption.xml
wn-verb.contact.xml
wn-verb.creation.xml
wn-verb.emotion.xml
wn-verb.motion.xml
wn-verb.perception.xml
wn-verb.possession.xml
wn-verb.social.xml
wn-verb.stative.xml
wn-verb.weather.xml
"

mkdir -p $TODIR

for f in $verb ; do
	echo -e "${YELLOW}PIPE: $f (v)${RESET}" 1>&2;
	./pipeline-verb.sh $FROMDIR/$f > $TODIR/$f &
done
wait

for f in $adj ; do
	echo -e "${YELLOW}PIPE: $f (a)${RESET}" 1>&2;
	./pipeline-adj.sh $FROMDIR/$f > $TODIR/$f &
done
wait

for f in $noun $adv ; do
	echo -e "${YELLOW}PIPE: $f${RESET}" 1>&2;
	./pipeline.sh $FROMDIR/$f > $TODIR/$f &
done
wait
