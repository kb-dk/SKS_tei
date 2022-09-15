# Søren Kierkegaard Skrifter (SKS) in TEI XML

# Intro

The material here was translated into TEI from the original kn1 format
by Karsten Kynde with some contributions from Sigfrid Lundberg.

The directories came to our project in a bagit format. We try to keep
it that way for the time being.

There are some ruby tools in
https://github.com/Det-Kongelige-Bibliotek/solr-and-snippets/utilities
for validating and creating bagit manifests.

# Modifications made to the TEI source

## Merging different kinds of comments

Originally this edition contained two kinds of comments stored under
different file names. Hence, there where many files called `kom.xml`
but then also files called `ekom.xml`. Both types where comments, but
the latter type where typically longer and contained comments to
information referenced in the `kom.xml` files. The main difference was
that the `ekom.xml` files never appeared in the printed version of the
data.

We felt that these two kinds were confusing for the users, and
therefore we manually merged the `ekom.xml` information into the
corresponding `kom.xml` and updated the references.

The following works included such `ekom.xml` files.

* [data/v1.9/jj](data/v1.9/jj)
* [data/v1.9/kk](data/v1.9/kk)
* [data/v1.9/bb](data/v1.9/bb)
* [data/v1.9/not13](data/v1.9/not13)
* [data/v1.9/not12](data/v1.9/not12)
* [data/v1.9/nb11](data/v1.9/nb11)
* [data/v1.9/not9](data/v1.9/not9)

The status of the first of these as of
[https://github.com/kb-dk/SKS_tei/tree/e29d5b9ea97109179c6d5205fb44ddc4e6fa3a83/data/v1.9/jj](April
22, 2022).

## Migrating map files to jp2000

The original service at http://sks.dk/ contained maps in `djvu`
format, for which there are hardly any plugins available for many
platforms. We migrated those maps to `jp2000` in our image
service. The references to the maps were collected in

```
data/v1.9/kort/kom.xml
```

which is transformed similarly to all other texts. Here is an example
http://text-test-02.kb.dk/text/sks-kort-kom-shoot-kbh_f2


## xml:id attributes on all elements 

We have added xml:id attributes to all elements that didn't have
that to begin with. Makes indexing, searching and navigation easier.

## Adding metadata to <sourceDesc> ... </sourceDesc>

We added a brief record to printed documents, containing a creation date:


```
 <bibl xml:id="sourceidm41">
    <title xml:id="sourceidm45399668669584" level="s">Søren Kierkegaards Skrifter</title>
    <title xml:id="sourceidm45399668668432">Enten – Eller. Første del</title>
    <title xml:id="sourceidm45399668667568" type="short">EE1</title>
    <author xml:id="sourceidm45399668666544">
         <name xml:id="sourceidm45399668665840">Søren Kierkegaard</name>
    </author>
    <date when="1843-02-20" xml:id="dateidm41">1843</date>
 </bibl>
```

That was necessary, since these files had no machine-readable dates.

