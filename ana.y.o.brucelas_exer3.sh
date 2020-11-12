#!/bin/bash

# ask user to enter 2 numbers separated by space
read -p "Enter two numbers:" a b 


# accept numerical input from user and assign them to var a and b
echo $a $b

# add 2 numerical input
ans=$(( $a + $b ))
#$ans = `expr $a + $b`

# display $a +$b = $ans
echo "$a + $b = $ans"
