#!/bin/bash
#set -x #Print a trace of simple commands (echo on)
#set -e #Exit immediately if error

toc()
{
defi-cli help | while read line ; do
	[ -z "$line" ] && continue  # ignore empty line
	arr=($line)
	firstword=${arr[0]}
	if [[ "$firstword" == "==" ]]
	then
		topic=${arr[1]}
		echo "[$topic](#$topic)"
	fi		
done
}

help()
{
defi-cli --version
echo
toc
echo

defi-cli help| while read line ; do
	[ -z "$line" ] && continue  # ignore empty line
	arr=($line)
	firstword=${arr[0]}
	if [[ "$firstword" == "==" ]]
	then
		topic=${arr[1]}
		echo "## $topic"
	else
		style='"font-family: monospace;"'
		echo "<details><summary>$line</summary><p style=$style>"
		defi-cli help $firstword | sed ':a;N;$!ba;s/\n/  \n/g'
		echo "</p></details>"
		echo
	fi		
done
}

#toc

help > defi-cli-help.md