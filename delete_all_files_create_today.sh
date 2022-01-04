#!/bin/bash
find . -mtime -1 -ls | awk '{
if (length($11) > 1)
print $11" " $12$13; }' | cut -d "/" -f2 | while read line
do
rm $line
done
