<p align="center">
<img width="256" height="256" src="images/xewn2.png">
</p>

# WNDB index.sense

The index comes in 3 flavours:

- index.sense
- index.sense.pools
- index.sense.legacy

Most libraries and applications expect to find an **index.sense** file in the *dict* directory. 

In case of compatibility problems or because of your application's needs and requirements, you can rename either *index.sense.pools* or *index.sense.legacy* to default target *index.sense*.

Here are the differences:

---

### index.sense
- all sensekeys are generated
- sensekeys may have upper-case characters in the lemma part of the sensekey which follows the lemma's form in the lexical entry
- there are as many sensekeys and lines as there are senses in the lexicographer's files
- if the sense is described as having case in the lemma form,
  only the cased sensekey appears in the index
- this is a one-one mapping between synset offset and sensekey
- proper index lookup is case-sensitive

### index.sense.pools
- all sensekeys are generated
- all sensekeys in the index are lower-cased
- if the sense is described as having upper-case in the lemma form:
    - only the lower-cased sensekey is present in the index
    - the cased sensekey is not used in the index
- index lookup, if case-sensitive,  has to lower-case the target
- each line is uniquely indexed by its sensekey
- in some cases a line may have multiple values grouped in a sense pool; this happens when lower-casing has the effect of merging two cased sensekeys into one and the values cannot be merged
- taking into account the entries past the first one requires non-standard processing but parsing until this break point is reached is standard.

### index.sense.legacy
- all sensekeys are lower-cased and come from the *dc:identifier* attribute
- they are not generated and any change reflects a decision on the lexicographer's side
- they cannot serve as a measure of database stability
- this is not a one-one mapping between synset offset and sensekey
- index lookup, if case-sensitive,  has to lower-case the target
- each line is uniquely indexed by its sensekey
- in some cases a line may have multiple values grouped in a sense pool; this happens when lower-casing has the effect of merging two cased sensekeys into one and the values cannot be merged

------------------

### examples


	line	line entry 				synset ref (for ease of reference)
	
S H A K E S P E A R E


*index.sense*

    33411:  Shakespeare%1:18:00:: 11291779 0 11      A

*index.sense.pools*
    
    168514: shakespeare%1:18:00:: 11291779 0 11      A

*index.sense.legacy*

    168773: shakespeare%1:18:00:: 11291779 0 11      A

B A R O Q U E


*index.sense*

    4338:  Baroque%1:28:00:: 15238185 0 0            A
    4339:  Baroque%3:01:00:: 02941415 1 0            B
    51398: baroque%1:07:00:: 04691427 1 0            C
    51399: baroque%3:01:00:: 02941415 1 0            D
    51400: baroque%5:00:00:fancy:00 01773174 0 1     E

*index.sense.pools*

    15746: baroque%1:07:00:: 04691427 1 0            C
    15747: baroque%1:28:00:: 15238185 0 0            A
    15748: baroque%3:01:00:: 02941415 1 0            B + D
    15749: baroque%5:00:00:fancy:00 01773174 0 1     E

*index.sense.legacy*

    15768: baroque%1:07:00:: 04691427 1 0            C
    15769: baroque%1:28:00:: 15238185 0 0            A
    15770: baroque%3:01:00:: 02941415 1 0            B + D
    15771: baroque%5:00:00:fancy:00 01773174 0 1     E

E A R T H

*index.sense*

    11379: Earth%1:15:00:: 08565436 3 3              A
    11380: Earth%1:17:00:: 09279481 0 51             B
    86752: earth%1:06:00:: 03460710 6 0              C
    86753: earth%1:09:00:: 05661297 5 0              D
    86754: earth%1:15:00:: 08565436 3 3              E
    86755: earth%1:17:01:: 09279481 0 51             F
    86756: earth%1:17:02:: 09342355 2 20             G
    86757: earth%1:27:01:: 14822959 1 20             H
    86758: earth%1:27:02:: 14824363 4 0              I
    86759: earth%2:35:00:: 01290951 1 0              J
    86760: earth%2:39:00:: 02147437 0 0              K

*index.sense.pools*

    58044: earth%1:06:00:: 03460710 6 0              C
    58045: earth%1:09:00:: 05661297 5 0              D
    58046: earth%1:15:00:: 08565436 3 3              A + E
    58047: earth%1:17:00:: 09279481 0 51             B
    58048: earth%1:17:01:: 09279481 0 51             F
    58049: earth%1:17:02:: 09342355 2 20             G
    58050: earth%1:27:01:: 14822959 1 20             H
    58051: earth%1:27:02:: 14824363 4 0              I
    58052: earth%2:35:00:: 01290951 1 0              J
    58053: earth%2:39:00:: 02147437 0 0              K

*index.sense.legacy*

    58131: earth%1:06:00:: 03460710 6 0              C
    58132: earth%1:09:00:: 05661297 5 0              D
    58133: earth%1:15:00:: 08565436 3 3              A + E
    58134: earth%1:17:00:: 09279481 0 51             B
    58135: earth%1:17:01:: 09342355 2 20             G
    58136: earth%1:27:00:: 14822959 1 20             H
    58137: earth%1:27:01:: 14824363 4 0              I
    58138: earth%2:35:00:: 01290951 1 0              J
    58139: earth%2:39:00:: 02147437 0 0              K

K B

*index.sense*

    19718:  KB%1:23:01:: 13614693 2 0                A
    19719:  KB%1:23:02:: 13614856 1 0                B
    123840: kB%1:23:01:: 13614693 2 0                C
    123841: kB%1:23:02:: 13614856 1 0                D
    123986: kb%1:23:00:: 13614983 0 0                E

*index.sense.pools*

    103880: kb%1:23:00:: 13614983 0 0                E
    103881: kb%1:23:01:: 13614693 2 0                A + C
    103882: kb%1:23:02:: 13614856 1 0                B + D

*index.sense.legacy*

    104023: kb%1:23:00:: 13614693 2 0                A + C
    104024: kb%1:23:02:: 13614856 1 0                B + D
    104025: kb%1:23:04:: 13614983 0 0                E

D O O M S D A Y

*index.sense*

    10974: Doomsday%1:28:00:: 15150947 0 0           A
    84375: doomsday%1:11:00:: 07343761 1 0           B
    84376: doomsday%1:28:00:: 15150947 0 0           C

*index.sense.pools*

    55308: doomsday%1:11:00:: 07343761 1 0           B
    55309: doomsday%1:28:00:: 15150947 0 0           A + C

*index.sense.legacy*

    55395: doomsday%1:11:00:: 07343761 1 0           B
    55396: doomsday%1:28:00:: 15150947 0 0           A + C

B I B L E

*index.sense*

    4933:  Bible%1:10:00:: 06423727 0 13             A
    53630: bible%1:10:00:: 06414639 1 0              B

*index.sense.pools*

    18575: bible%1:10:00:: 06423727 0 13 06414639 1 0    A + B

*index.sense.legacy*

    18601: bible%1:10:00:: 06423727 0 13             A
    18602: bible%1:10:01:: 06414639 1 0              B

B O O K

*index.sense*

    5292:  Book%1:10:01:: 06423727 8 0               A
    5293:  Book%1:10:02:: 06454173 7 0               B
    56733: book%1:06:01:: 02870146 1 10              C
    56734: book%1:06:02:: 02870616 10 0              D
    56735: book%1:10:01:: 06387073 9 0               E
    56736: book%1:10:02:: 06403025 0 46              F
    56737: book%1:10:03:: 06628953 2 2               G
    56738: book%1:10:04:: 07020291 3 1               H
    56739: book%1:14:01:: 07959883 6 0               I
    56740: book%1:14:02:: 07960111 5 0               J
    56741: book%1:21:00:: 13391813 4 0               K
    56742: book%2:31:00:: 00678081 0 3               L
    56743: book%2:41:01:: 02498534 2 1               M
    56744: book%2:41:02:: 02498716 1 1               N
    56745: book%2:41:03:: 02599988 3 0               O

*index.sense.pools*

    22046: book%1:06:01:: 02870146 1 10              C
    22047: book%1:06:02:: 02870616 10 0              D
    22048: book%1:10:01:: 06423727 8 0 06387073 9 0      A + E
    22049: book%1:10:02:: 06403025 0 46 06454173 7 0     F + B
    22050: book%1:10:03:: 06628953 2 2               G
    22051: book%1:10:04:: 07020291 3 1               H
    22052: book%1:14:01:: 07959883 6 0               I
    22053: book%1:14:02:: 07960111 5 0               J
    22054: book%1:21:00:: 13391813 4 0               K
    22055: book%2:31:00:: 00678081 0 3               L
    22056: book%2:41:01:: 02498534 2 1               M
    22057: book%2:41:02:: 02498716 1 1               N
    22058: book%2:41:03:: 02599988 3 0               O

*index.sense.legacy*

    22075: book%1:06:00:: 02870146 1 10              C
    22076: book%1:06:02:: 02870616 10 0              D
    22077: book%1:10:00:: 06403025 0 46              F + B
    22078: book%1:10:01:: 07020291 3 1               H
    22079: book%1:10:02:: 06628953 2 2               G
    22080: book%1:10:03:: 06387073 9 0               E
    22081: book%1:10:04:: 06423727 8 0               A + B
    22082: book%1:10:05:: 06454173 7 0               B
    22083: book%1:14:00:: 07959883 6 0               I
    22084: book%1:14:01:: 07960111 5 0               J
    22085: book%1:21:00:: 13391813 4 0               K
    22086: book%2:31:00:: 00678081 0 3               L
    22087: book%2:41:00:: 02498534 2 1               M
    22088: book%2:41:01:: 02498716 1 1               N
    22089: book%2:41:03:: 02599988 3 0               O

W O R D N E T

*index.sense*

    39274:  WordNet%1:10:00:: 06631608 1 0           A
    210332: wordnet%1:10:00:: 06631952 0 0           B

*index.sense.pools*

    209326: wordnet%1:10:00:: 06631952 0 0 06631608 1 0      A + B

*index.sense.legacy*

    209629: wordnet%1:10:00:: 06631608 1 0           A
    209630: wordnet%1:10:01:: 06631952 0 0           B

