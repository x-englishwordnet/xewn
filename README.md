<p align="center">
<img width="256" height="256" src="images/xewn2.png">
</p>

# X Open English Wordnet

<p align="center">
<sub>
<i>X</i> stands for '<b>trans</b>formed' (as in <i>xform</i>) or 'e<b>X</b>tended'</b>
</sub>
</p>


Xtended Open English Wordnet builds on upstream  [globalwordnet/english-wordnet](https://github.com/globalwordnet/english-wordnet). It does not live a life of its own. Rather, it brings extra data, tools and constraints to the core project. **The set of core data is exactly the same.**

Please note this independent initiative is not endorsed by the Global Wordnet Association. Data issues should be referred to the upstream project.

***

This project  is designed to produce a __transformed__ version of Open English Wordnet data in the form of

- WordNet-format data in the __wndb__ directory
- SQL versions

***

![Dataflow1](images/dataflow1.png  "Dataflow")

### Home

The project has migrated to a space of its own: https://github.com/x-englishwordnet/ with

- [xewn](https://github.com/x-englishwordnet/xewn), the master project
- [schemas](https://github.com/x-englishwordnet/schemas) 
- [wndb](https://github.com/x-englishwordnet/wndb), a release version that can work as a replacement for w3.1.dict.tar.gz
- [mysql](https://github.com/x-englishwordnet/mysql) a SQL release for MySql
- [sqlite](https://github.com/x-englishwordnet/mysql) a SQL release for Sqlite

## Resources

See [Resources section](README-resources.md)

## Tools

See [Tools section](README-tools.md)

## SQL

See [SQL section](README-sql.md)

![Dataflow2](images/dataflow2.png  "Dataflow (continued)")

## Browsers

See [Browsers section](README-browsers.md)

### Build tag

In each directory a *build* file is to be found that indicates the upstream commit the data is derived from.
