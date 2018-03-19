#!/bin/bash
data=($(cat Right.txt))
for i in "${!data[@]}";
do
	commandString=" -crop 104x832+0+0 ${data[$i]}"".jpg ${data[$i]}-left1-16.jpg"
	gm convert $commandString
	commandString=" -crop 208x832+0+0 ${data[$i]}"".jpg ${data[$i]}-left2-16.jpg"
	gm convert $commandString
	commandString=" -crop 312x832+0+0 ${data[$i]}"".jpg ${data[$i]}-left3-16.jpg"
	gm convert $commandString
	commandString=" -crop 416x832+0+0 ${data[$i]}"".jpg ${data[$i]}-left4-16.jpg"
	gm convert $commandString

	commandString=" -crop 1560x832+104+0 ${data[$i]}"".jpg ${data[$i]}-right1-16.jpg"
	gm convert $commandString
	commandString=" -crop 1456x832+208+0 ${data[$i]}"".jpg ${data[$i]}-right2-16.jpg"
	gm convert $commandString
	commandString=" -crop 1352x832+312+0 ${data[$i]}"".jpg ${data[$i]}-right3-16.jpg"
	gm convert $commandString
	commandString=" -crop 1248x832+416+0 ${data[$i]}"".jpg ${data[$i]}-right4-16.jpg"
	gm convert $commandString

	commandString=" +append ${data[$i]}-right1-16.jpg ${data[$i]}-left1-16.jpg ${data[$i]}-angling1.jpg"
	gm convert $commandString
	commandString=" +append ${data[$i]}-right2-16.jpg ${data[$i]}-left2-16.jpg ${data[$i]}-angling2.jpg"
	gm convert $commandString
	commandString=" +append ${data[$i]}-right3-16.jpg ${data[$i]}-left3-16.jpg ${data[$i]}-angling3.jpg"
	gm convert $commandString
	commandString=" +append ${data[$i]}-right4-16.jpg ${data[$i]}-left4-16.jpg ${data[$i]}-angling4.jpg"
	gm convert $commandString


done
