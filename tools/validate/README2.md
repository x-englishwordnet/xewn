# oewn-validation
XML validation of English Wordnet using FastXML Woodstox

Two XSD's are provided:

* one with IDREF validation (checks that each ID reference matches an existing ID)

* the other without (only checks that each ID is a well-formed NCName)

*Needed:*

* java runtime >= 8

* transform.sh

* validator.jar

* WN-LMF-1.X[-relax_idrefs].xsd

* types-1.X.xsd

* dc.xsd


*How to run on all files in a dir:*

```
./validate2.sh [xsd] [indir] -dir
```

*How to run on a list of files:*

```
./validate2.sh [xsd] [xml]+
```
