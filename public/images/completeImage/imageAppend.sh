#!/bin/bash

imageName=$1
path="/root/IdeaProjects/StreetViewImageServer/public/images/rawImages/"
path2="/root/IdeaProjects/StreetViewImageServer/public/images/completeImage/"
for j in 0 1 2 3
do
	commandString=" +append "
	for i in 0 1 2 3 4 5 6
	do
		commandString=$commandString$path$imageName$i$j".jpg "
	done
	commandString=$commandString" "$path$imageName"temp"$j".jpg"
	gm convert $commandString
done
commandString=" -append "
for i in 0 1 2 3
do
	commandString=$commandString$path$imageName"temp"$i".jpg "
done
commandString=$commandString" "$path$imageName"appended.jpg"
gm convert $commandString
#echo "tt"
commandString=" -crop 1664x832+0+0 "$path$imageName"appended.jpg "$path2$imageName".jpg"
#echo $commandString
gm convert $commandString
