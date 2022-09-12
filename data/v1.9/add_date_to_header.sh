#!/bin/bash

# (grep -e 'type="publishedWritings"'  */txt.xml;grep -e 'type="unpublishedWritings"'  */txt.xml)   | sed 's/:.*$//'

FILES=`grep -P 'type="(publishedWritings|unpublishedWritings)"'  */txt.xml  | sed 's/:.*$//'`

for file in ${FILES[@]}; do
    title=`echo $file | sed 's/\/.*xml$//' | tr [:lower:] [:upper:]`

    lctitle=`echo $file | sed 's/\/.*xml$//'`

    date=`xpath -q -e '//tr[td[3]="'${title}'"]/td[9]/text()' toc.xml `
    
    echo $title $date

    if [[ $date == 18* ]]; then
	xsltproc --seed-rand `rand` --stringparam published_date $date   edit_header.xsl $file | xmllint --format - > $lctitle/shit.xml
    fi
    
done
