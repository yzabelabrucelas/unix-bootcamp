#!/bin/bash

#Write a shell script that will transfer a single file from server1 to a destination server. 

#Conditions: 
#•	Script must not ask for a password 
#•	Filename must be passed on as argument.
#•	Destination server must be passed on as argument

echo "Usage: $0 $1 $2"
#echo "File: $1"
#echo "Destination Server: $2"

scp -r $1 $2:~/unix_bootcamp/day5