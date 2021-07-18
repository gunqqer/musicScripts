#!/bin/bash 
#OH BOY HERE WE GO WITH BAD SCRIPTING
#If you wanted something good you came to the wrong party fam
#Copyright: GPLv3
#First arg source dir, will find any audio files with the right extention (for now, flac, m4a, mp3)
#Second arg target dir, will create (if needed) folders for artist and album
#Yes, I don't test if any of the dirs exist, so sue me


SOURCE=$1
TARGET=$2

parseAndMove()
{
	echo "$1"
	#Remove prefix and change to lowercase
	#Prob should change to a single call of exiftools to be more efficient
	albumartist=$(exiftool -fast -S -albumartist -- "$1" | sed -e 's:.*\: ::' -e 's/\(.*\)/\L\1/' -e "s/\b\(.\)/\u\1/g")
	album=$(exiftool -fast -S -album -- "$1" | sed -e 's:.*\: ::' -e 's/\(.*\)/\L\1/' -e "s/\b\(.\)/\u\1/g")
	if [ -n "$albumartist" ];
	then
		artist="$albumartist"
	else
		artist=$(exiftool -fast -S -artist -- "$1" | sed -e 's:.*\: ::' -e 's/\(.*\)/\L\1/' -e "s/\b\(.\)/\u\1/g")
	fi
	echo "Dest: $2/$artist/$album/"
	mkdir -p "$2/$artist/$album/"
	mv "$1" "$2/$artist/$album/"
}
export -f parseAndMove

find "$SOURCE" -type f -iregex '.*\.\(wav\|mp3\|flac\|m4a\)$' | parallel -j 6 --bar --eta parseAndMove {} "$TARGET"
echo "Done!"
exit

