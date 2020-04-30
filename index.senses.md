# WNDB index.sense


The index comes in 3 flavours:

- index.sense
- index.sense.cased
- index.sense.legacy

Most libraries and applications expect to find an **index.sense** file in the *dict* directory. 

In case of compatibility problems or because of your application's needs and requirements, you can rename either *index.sense.cased* or *index.sense.legacy* to default target *index.sense*.

Here are the differences:

---

### index.sense
- all sensekeys are generated
- if the sense is described as having case in the lemma form:
    - the lower-cased sensekey comes first
    - the cased sensekey comes immediately after
- index lookup, if case-insensitive,  will presumably land on the first one

### index.sense.cased
- all sensekeys are generated
- if the sense is described as having case in the lemma form,
  only the cased sensekey appears in the index
- this is a one-one mapping between synset offset and sensekey
- index lookup may be case-sensitive or case-insensitive 

### index.sense.legacy
- all sensekeys are lower-cased and come from the *dc:identifier* attribute
- they are not generated and any change reflects a decision on the lexicographer's side
- they cannot serve as a measure of database stability
- this is not a one-one mapping between synset offset and sensekey

------------------

### examples


	line	line entry 									synset ref (for ease of reference)

S H A K E S P E A R E

*index.sense*

	207800:	shakespeare%1:18:00:: 11291779 0 11			A
	207801:	Shakespeare%1:18:00:: 11291779 0 11			A
	253441:	william_shakespeare%1:18:00:: 11291779 0 0	A
	253442:	William_Shakespeare%1:18:00:: 11291779 0 0	A
	
*index.sense.cased*

	168804:	Shakespeare%1:18:00:: 11291779 0 11			A
	208411:	William_Shakespeare%1:18:00:: 11291779 0 0	A
	
*index.sense.legacy*

	168779:	shakespeare%1:18:00:: 11291779 0 11			A
	208379:	william_shakespeare%1:18:00:: 11291779 0 0	A
	
B A R O Q U E

*index.sense*

	19777:	baroque%1:07:00:: 04691427 1 0						C
	19778:	baroque%1:28:00:: 15238185 0 0				A
	19779:	Baroque%1:28:00:: 15238185 0 0				A
	19780:	baroque%3:01:00:: 02941399 1 0					B
	19781:	Baroque%3:01:00:: 02941399 1 0					B
	19782:	baroque%5:00:00:fancy:00 01773173 0 1					D
	
*index.sense.cased*

	15770:	baroque%1:07:00:: 04691427 1 0						C
	15771:	Baroque%1:28:00:: 15238185 0 0				A
	15772:	baroque%3:01:00:: 02941399 1 0					B
	15773:	Baroque%3:01:00:: 02941399 1 0					B
	15774:	baroque%5:00:00:fancy:00 01773173 0 1					D
	
*index.sense.legacy*

	15768:	baroque%1:07:00:: 04691427 1 0						C
	15769:	baroque%1:28:00:: 15238185 0 0				A
	15770:	baroque%3:01:00:: 02941399 1 0					B
	15771:	baroque%5:00:00:fancy:00 01773173 0 1					D
	
E A R T H

*index.sense*

	69663:	earth%1:06:00:: 03460710 6 0				A
	69664:	earth%1:09:00:: 05661297 5 0					B
	69665:	earth%1:15:00:: 08565436 3 3						C
	69666:	Earth%1:15:00:: 08565436 3 3						C
	69667:	earth%1:17:00:: 09279481 0 51							D
	69668:	Earth%1:17:00:: 09279481 0 51							D
	69669:	earth%1:17:01:: 09279481 0 51							D
	69670:	earth%1:17:02:: 09342355 2 20								E
	69671:	earth%1:27:01:: 14822959 1 20									F
	69672:	earth%1:27:02:: 14824363 4 0										G
	69673:	earth%2:35:00:: 01290950 1 0											H
	69674:	earth%2:39:00:: 02147436 0 0													I
	
*index.sense.cased*

	58138:	earth%1:06:00:: 03460710 6 0				A
	58139:	earth%1:09:00:: 05661297 5 0					B
	58140:	earth%1:15:00:: 08565436 3 3						C
	58141:	Earth%1:15:00:: 08565436 3 3						C
	58142:	Earth%1:17:00:: 09279481 0 51							D
	58143:	earth%1:17:01:: 09279481 0 51							D
	58144:	earth%1:17:02:: 09342355 2 20								E
	58145:	earth%1:27:01:: 14822959 1 20									F
	58146:	earth%1:27:02:: 14824363 4 0										G
	58147:	earth%2:35:00:: 01290950 1 0											H
	58148:	arth%2:39:00:: 02147436 0 0												I
	
*index.sense.legacy*

	58131:	earth%1:06:00:: 03460710 6 0				A
	58132:	earth%1:09:00:: 05661297 5 0					B
	58133:	earth%1:15:00:: 08565436 3 3						C
	58134:	earth%1:17:00:: 09279481 0 51							D
	58135:	earth%1:17:01:: 09342355 2 20								E
	58136:	earth%1:27:00:: 14822959 1 20									F
	58137:	earth%1:27:01:: 14824363 4 0										G
	58138:	earth%2:35:00:: 01290950 1 0											H
	58139:	earth%2:39:00:: 02147436 0 0												I
	
	
	