#!/bin/bash

#Write a shell script that will accept 2 numerical values and display their sum
echo "Usage: $0 $1 $2"

#add 2 numerical input
sum=$(( $1 + $2 ))
echo "Output: $1 + $2 = $sum" 