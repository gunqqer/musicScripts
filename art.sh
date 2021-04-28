#!/bin/bash
W3MIMGDISPLAY="/usr/lib/w3m/w3mimgdisplay"
FILENAME=$1
FONTH=14
FONTW=8
COLUMNS="$(tput cols)"
LINES="$(tput lines)"
read -r width height <<< $(echo -e "5;$FILENAME" | $W3MIMGDISPLAY)
termw="$(($COLUMNS * $FONTW))"
termh="$(($LINES * $FONTH))"

w3m_args="0;1;0;0;$termw;$termh;;;;;$FILENAME\n"
echo $w3m_args

echo -e "$w3m_args"|"$W3MIMGDISPLAY"

