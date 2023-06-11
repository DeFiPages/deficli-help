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
    echo "<details><summary>$line</summary><p>"
    #append two spaces for markdown linebreak at end of every line.
    defi-cli help $firstword | sed ':a;N;$!ba;s/\n/  \n/g'
    echo "</p></details>"
    echo
  fi
done
}

help > defi-cli-help.md