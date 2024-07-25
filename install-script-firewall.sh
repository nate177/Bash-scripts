#!/bin/bash
ufw=ufw
gufw=gufw

if command -v $ufw
then
	echo "$ufw is available, Now Running"
else
	echo "$ufw is NOT available, installing it....."
	sudo pacman -Syu
	sudo pacman -S ufw
fi

if command -v $
then
	echo"$gufw is available,starting daemon with systemctl..."
 else
 	echo "$gufw is NOT available, finding package. 1.......2.....3.......4.......5 also installing gufw GUI"
   	sudo pacman -S gufw
