#!/bin/bash

#accept 5 command line args


echo "File Name: $0"
echo "First Parameter : $1"
echo "Second Parameter : $2"
echo "Third Parameter: $3"
echo "Fourth Parameter: $4"
echo "Fifth Parameter: $5"

echo "Total Number of Parameters : $#"

#print each args in newline
for TOKEN in $*
do
   echo $TOKEN
done	
