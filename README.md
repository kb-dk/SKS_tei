# Søren Kierkegaard Skrifter (SKS) in TEI XML

# Intro

The material here was translated into TEI from the original kn1 format
by Karsten Kynde with some contributions from Sigfrid Lundberg.

Here we have added xml:id attributes to all elements that didn't have
that to begin with. Makes indexing, searching and navigation easier.

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

## Migrating map files to jp2000

The original service at http://sks.dk/ contained maps in `djvu`
format. We migrated those maps to `jp2000` in our image service. 
