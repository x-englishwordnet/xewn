<p align="center">
<img width="256" height="256" src="images/xewn2.png">
</p>

# X Open English Wordnet

## SQL

__sqlite__ [version](https://github.com/x-englishwordnet/sqlite).
__mysql__ [version](https://github.com/x-englishwordnet/mysql).

![Dataflow2](images/dataflow2.png  "Dataflow (continued)")

## SQLUNET (SQL-Unified *Net)

SqlUnet compiles the WordNet, PWN3.0, PWN3.1, VerbNet, Propank, FrameNet, PredicateMatrix, SUMO ... **so that their tables are joinable**, in effect **unifying** these databases into one.  The Semantikos application allow browsing across database boundaries and **exploring senses and semantic roles**.

A SqlUNet unified database has been compiled with EWN as its core and Semantikos can download it.

The data is [here](https://sourceforge.net/projects/sqlunet/files/6.0.0) and again comes in 3 flavours mysql, sqlite and standard SQL. 

![Dataflow2](images/dataflow2.png  "Dataflow (continued)")

## SQL builder

The [SQL builder](http://sqlunetbuilder.sourceforge.net/) generates *myslq* and *sqlite* versions of the data. It is part of the [SQLUnet](http://sqlunet.sourceforge.net/) project.

## Android Semantikos application

The Android Semantikos application uses the sqlite version. So it's now past the proof-of-concept stage.

Please note the the Semantikos application comes with a feature that allows the user to peek at the SQL queries it uses. 
