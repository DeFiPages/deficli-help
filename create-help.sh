#!/bin/bash


help()
{
defi-cli --version

collapsend=""

defi-cli help | while read line ; do
	[ -z "$line" ] && continue  # ignore empty line
	firstword=${line%% *}
	if [[ "$firstword" == "==" ]]
	then
		echo "$collapsend"
		echo
		echo "<details><summary><b>$line</b></summary><p>"
		collapsend="</p></details>"
	else
		echo "<details><summary>$line</summary><p>"
		defi-cli help $firstword
		echo "</p></details>"
		echo
	fi		
done
echo "$collapsend"
}

help > defi-cli-help.md