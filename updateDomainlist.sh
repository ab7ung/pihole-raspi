#!/bin/bash
while read file; do
    wget ${file} -O foo.list -q
    cat foo.list >> blockdomain.list
done < listex.url
rm -rf foo.list
cat blockdomain.list > domainlist.list
rm -rf blockdomain.list
pihole -g
