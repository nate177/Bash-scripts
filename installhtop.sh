#!/bin/bash

program=htop

if command -v $program
then
	echo "$program is available, let's run it man..."
else
	echo "$program is NOT available, installing it....."
	sudo pacman -Syu
	sudo pacman -S htop
fi

$program
