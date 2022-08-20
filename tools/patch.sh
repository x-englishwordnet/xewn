#!/bin/bash

R='\u001b[31m'
B='\u001b[34m'
Z='\u001b[0m'
D='\u001b[90m'

# D I R S

THISDIR=`dirname $(readlink -m "$0")`

# src
SRCDIR=${THISDIR}/../src
SRCDIR=$(readlink -m "${THISDIR}/../src/xml")

echo -e "${R}* Patch ${Z}"

echo "nuisance"
sed 's/members="oewn-annoyance-n oewn-bother-n oewn-botheration-n oewn-pain-n oewn-infliction-n oewn-pain_in_the_neck-n oewn-pain_in_the_ass-n"/members="oewn-annoyance-n oewn-nuisance-n oewn-bother-n oewn-botheration-n oewn-pain-n oewn-infliction-n oewn-pain_in_the_neck-n oewn-pain_in_the_ass-n"/' ${SRCDIR}/wn-noun.cognition.xml > ${SRCDIR}/wn-noun.cognition.xml.fixed
rm ${SRCDIR}/wn-noun.cognition.xml
mv ${SRCDIR}/wn-noun.cognition.xml.fixed ${SRCDIR}/wn-noun.cognition.xml 

echo "Yellow race"
sed 's/members="oewn-Mongolian_race-n oewn-Mongoloid_race-n"/members="oewn-Mongolian_race-n oewn-Mongoloid_race-n oewn-Yellow_race-n"/' ${SRCDIR}/wn-noun.person.xml > ${SRCDIR}/wn-noun.person.xml.fixed
rm ${SRCDIR}/wn-noun.person.xml
mv ${SRCDIR}/wn-noun.person.xml.fixed ${SRCDIR}/wn-noun.person.xml 

# Uneven quotes in n-15397190:The state or condition of not being standard.; "At neither age did nonstandardness of dialect or accent cause a problem for teacher-pupil communication, so it is unlikely that it was in any direct manner a cause of the later associated lower attainment.""

#wn-noun.attribute.xml:55487
#<Example>At neither age did nonstandardness of dialect or accent cause a problem #for teacher-pupil communication, so it is unlikely that it was in any direct manner a cause of the later associated lower attainment.&quot;</Example>

#grep -n -B 10 '&quot;' ${SRCDIR}/wn-noun.attribute.xml


#grep -n -B 10 '&quot;' ${SRCDIR}/wn-noun.attribute.xml
#grep -n -A 5 'id="oewn-92422926-n' ${SRCDIR}/wn-noun.attribute.xml
#sed 's/lower attainment.&quot;/lower attainment./' ${SRCDIR}/wn-noun.attribute.xml | grep -n -A 5 'id="oewn-92422926-n'
echo "uneven quotes"
sed 's/lower attainment.&quot;/lower attainment./' ${SRCDIR}/wn-noun.attribute.xml > ${SRCDIR}/wn-noun.attribute.xml.fixed
#grep -n -A 5 'id="oewn-92422926-n' ${SRCDIR}/wn-noun.attribute.xml.fixed
rm ${SRCDIR}/wn-noun.attribute.xml
mv ${SRCDIR}/wn-noun.attribute.xml.fixed ${SRCDIR}/wn-noun.attribute.xml 
#grep -n -A 5 'id="oewn-92422926-n' ${SRCDIR}/wn-noun.attribute.xml

