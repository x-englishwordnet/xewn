# WordNet WNDB parser

![Dataflow](images/dataflow.png  "Dataflow")

## WNDB parser

This library parses WNDB(5WN) files into Plain Old Java Objects. These objects are not a model but come in handy when it comes to building one.

Project [parse](https://github.com/oewntk/parse)

## Command line

`parse.sh [WNDBDIR]`

parse the WNDB database data

`parseIndex.sh [WNDBDIR]`

parse the WNDB database word index

`parseSenses.sh [WNDBDIR]`

parse the WNDB database sense index

`parse1.sh [WNDBDIR] [SYNSETID]`

`parse1.sh [WNDBDIR] -sense [SENSEID]`

`parse1.sh [WNDBDIR] -offset [POS] [OFS]`

parse the WNDB database at expected *offset* of *data.{noun|verb|adj|adv}*

*where*

[WNDBDIR] the WNDB directory where WordNet files are

[POS] n|v|a|r

[SENSEID] sense id

[SYNSETID] synset id

[OFS] offset

If WNHOME20, WNHOME21, WNHOME30, WNHOME31, WNHOMEXX environment variables are defined, you can refer to them by 20, 21, 30, 31, 00 respectively, instead of the full path.

## Maven Central

        <groupId>io.github.oewntk</groupId>
        <artifactId>parse_wndb</artifactId>
        <version>2.0.0</version>
