#!/bin/bash
SOURCE="`dirname $0`/source"
file="$SOURCE/grub"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "$file not found."
fi
