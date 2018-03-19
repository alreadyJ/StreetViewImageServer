#!/bin/bash
data=($(cat leftData.txt))
for i in "${!data[@]}";
do
	commandString=" -crop 1560x832+0+0 ${data[$i]}"".jpg ${data[$i]}-left1-16.jpg"
	gm convert $commandString
	commandString=" -crop 1456x832+0+0 ${data[$i]}"".jpg ${data[$i]}-left2-16.jpg"
	gm convert $commandString
	commandString=" -crop 1352x832+0+0 ${data[$i]}"".jpg ${data[$i]}-left3-16.jpg"
	gm convert $commandString
	commandString=" -crop 1248x832+0+0 ${data[$i]}"".jpg ${data[$i]}-left4-16.jpg"
	gm convert $commandString
	
	commandString=" -crop 1560x832+1560+0 ${data[$i]}"".jpg ${data[$i]}-right1-16.jpg"
	gm convert $commandString
	commandString=" -crop 1456x832+1456+0 ${data[$i]}"".jpg ${data[$i]}-right2-16.jpg"
	gm convert $commandString
	commandString=" -crop 1352x832+1352+0 ${data[$i]}"".jpg ${data[$i]}-right3-16.jpg"
	gm convert $commandString
	commandString=" -crop 1248x832+1248+0 ${data[$i]}"".jpg ${data[$i]}-right4-16.jpg"
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
