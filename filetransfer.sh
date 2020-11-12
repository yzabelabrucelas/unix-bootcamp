#!/bin/bash

#Write a shell script that will deploy files (through scp) to a destination server. Password must be encrypted.
echo "Usage: $0"

#$HOME/.ssh/known_hosts
#host error (1)
#ssh Ana@40.85.152.189 'ls -lrt; cd unix_bootcamp; ls -lrt;scp -r ~/unix_bootcamp/day5 Ana@40.85.152.189:~/unix_bootcamp'

#2
ssh Ana@40.85.152.189 'ls -lrt; cd unix_bootcamp; ls -lrt'
scp -r ~/unix_bootcamp/day5 Ana@40.85.152.189:~/unix_bootcamp