#!/bin/bash
#note: does not work with remote URLs, only URIs, image *must* be local
#Yes I should not hard code these like this
imageViewer="/home/gunqqer/.cargo/bin/viu"
playerName=cmus


currentUrl="$(urlencode -d "$(playerctl --player=$playerName metadata mpris:artUrl)" | sed 's/^file:\/\///')"
clear
$imageViewer "$currentUrl"
while true; do
	url="$(urlencode -d "$(playerctl --player=$playerName metadata mpris:artUrl)" | sed 's/^file:\/\///')"
	if [ "$currentUrl" != "$url" ]; then
		currentUrl="$url"
		clear
		$imageViewer "$url"
	fi
	sleep 10
done
