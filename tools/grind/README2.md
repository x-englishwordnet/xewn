# English WordNet grinder

Refer to [globalwordnet/english-wordnet](https://github.com/globalwordnet/english-wordnet)
This is designed to produce __transformed__ English Wordnet data in the form of WordNet-format data in the __wndb__ directory

![Dataflow1](images/dataflow1.png  "Dataflow")

## WNDB parser

[ewn-grind](https://github.com/1313ou/ewn-grind) 
This produces WNDB(5WN) format files from the merged XML file.

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

[POS]     n|v|a|r

[SENSEID]     sense id

[SYNSETID]    synset id

[OFS]     offset

If WNHOME20, WNHOME21, WNHOME30, WNHOME31, WNHOMEXX environment variables are defined, you can refer to them by 20, 21, 30, 31, 00 respectively, instead of the full path.
