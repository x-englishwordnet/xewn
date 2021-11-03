<p align="center">
<img width="256" height="256" src="images/xewn2.png">
</p>

# Tools

The tools' location:

- [transforming, merging, validating](https://github.com/x-englishwordnet/xml-transform-merge-validate)
- [ewn-grind](https://github.com/x-englishwordnet/grind)


### Transformer

[ewn-transformation](https://github.com/x-englishwordnet/xml-transform-merge-validate/tree/master/transform) 
[ewn-transformation3](https://github.com/x-englishwordnet/xml-transform-merge-validate/tree/master/transform3) 
Transformations are expressed in XSLT 1.0 or 3.0 to make processing __declarative__, __versatile__. Transformations are __pipelined__.

In some cases it is easier to declare transformations in XSLT 3.0. A Woodstox transformer is then used.

This part has been obsoleted so that the grinder now works with current OEWN XML files in the *src* directory.

### Merge tool

[ewn-merging](https://github.com/x-englishwordnet/xml-transform-merge-validate/tree/master/merge) 
XSLT merging of lexicographer files.
Merges the XML files into one using XSLT 3.0-conformant Saxon 9.9 powerhouse transformer

### Validator

[ewn-validation](https://github.com/x-englishwordnet/xml-transform-merge-validate/tree/master/validate) 
[ewn-validation2](https://github.com/x-englishwordnet/xml-transform-merge-validate/tree/master/validate2) 
Validation is based on XSD which permits fine-grained strict type validation.
Several schemas are provided.
Types have been factored out.
Two versions of the schemas are available : one relaxing ID references, to be used with split lexicographer files (some references cross file boundaries, notably derivations), the other that does not (to be used with self-contained merged file) that imposes extra constraints of existence.

### WNDB grinder

[ewn-grind](https://github.com/x-englishwordnet/grind) 
This produces WNDB(5WN) format files from the merged XML file.

### SQL builder

[sqlunetbuilder](http://sqlunetbuilder.sourceforge.net/) 
SQL builder to generate *myslq* and *sqlite* versions of the data. This is based on [SQLUnet](http://sqlunet.sourceforge.net/)  (SQL Unified *Net)
