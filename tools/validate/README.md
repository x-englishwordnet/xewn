# ewn-validation
XML validation of English Wordnet

Two XSD's are provided:

* one with IDREF validation (checks that each ID reference matches an existing ID, can be VERY long)

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
./validate.sh [xsd] [indir] -dir
```

*How to run on a list of files:*

```
./validate.sh [xsd] [xml]+
```
