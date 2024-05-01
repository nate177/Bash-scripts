#!/bin/bash
program2=ufw
program=htop

if command -v $program
then
	echo "$program is available, Now Running"
else
	echo "$program is NOT available, installing it....."
	sudo pacman -Syu
	sudo pacman -S htop
fi

if command -v $program2
then
	echo"$program2 is available,starting daemon with systemctl..."
 else
 	echo "$program2 is NOT available, finding package1.......2.....3.......3.........5 also installing gufw GUI"
  	sudo pacman -S ufw
   	sudo pacman -S gufw
