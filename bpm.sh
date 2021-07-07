#!/bin/bash
#GLPv3 baby!

SOURCEDIR=$1

getBPM()
{
	bpm=$(exiftool -bpm "$1" | grep -oP '\d*$')
	if [ -n "$bpm" ] 
	then
		echo -n "BPM: $bpm " >> bpm.txt
		exiftool -S -title "$1" >> bpm.txt
	fi
}
export -f getBPM

echo -en '\n\n' >> bpm.txt

find "$SOURCEDIR" -type f -iregex '.*\.\(wav\|mp3\|flac\|m4a\)$' | parallel -j 1 --bar -eta getBPM {}
