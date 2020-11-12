#!/bin/sh
#display running processes
ps -f

#output process info in a text file named pid.txt, sorted in ASC
ps -f | sort > pid.txt

#filter pid.txt to display only "bash" processes, output written on pid2.txt
grep "bash" pid.txt >> pid2.txt

#move pid2.txt in dir named pid2
mkdir pid2; mv pid2.txt pid2

#archive the pid2 dir into pid.tar
tar cvf pid2.tar.gz pid2

#remove the pid2 dir
rm -rf pid2

