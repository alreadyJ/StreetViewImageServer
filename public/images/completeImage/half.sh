#!/bin/bash
data=($(cat data.txt))
for i in "${!data[@]}";
do
	for j in {0..18}
	do
		commandString=" -crop 832x832+0+0 ${data[$i]}$j"".jpg ${data[$i]}$j-left.jpg"
		if [ $j == 0 ]
		then
			commandString=" -crop 832x832+0+0 ${data[$i]}.jpg ${data[$i]}-left.jpg"
		fi
		gm convert $commandString
		commandString=" -crop 832x832+832+0 ${data[$i]}$j"".jpg ${data[$i]}$j-right.jpg"
		if [ $j == 0 ]
		then
			commandString=" -crop 832x832+832+0 ${data[$i]}.jpg ${data[$i]}-right.jpg"
		fi
		gm convert $commandString
	done
done

for i in "${!data[@]}";
do
	for j in {0..18}
	do
	commandString=" +append ${data[$i]}$j""-right.jpg ${data[$i]}$j""-left.jpg ${data[$i]}$j-ca.jpg"
	if [ $j == 0 ]
	then
		commandString=" +append ${data[$i]}-right.jpg ${data[$i]}-left.jpg ${data[$i]}-ca.jpg"
	fi
	gm convert $commandString
	done
done
