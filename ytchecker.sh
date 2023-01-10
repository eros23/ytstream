#!/bin/sh

USER="pi"
HOME="/home/${USER}"

sleep 10
while true
do
    frameA=$(tail ${HOME}/ffmpeg.log -n 1 | sed -nr 's/.*frame=(.*)fps.*/\1/p')
    echo "$frameA"
    sleep 5
    frameB=$(tail ${HOME}/ffmpeg.log -n 1 | sed -nr 's/.*frame=(.*)fps.*/\1/p')
    echo "$frameB"

    if [ "$frameA" = "$frameB" ]
    then
        echo "Stream has hung"
	printf "%s - Stream has hung\n" "$(date)" >> stream.log
        pkill ffmpeg
        echo "killed ffmpeg..."
	printf "%s - Killed ffmpeg...\n" "$(date)" >> stream.log
        echo "Waiting 5 secs"
        sleep 5
        bash ${HOME}/ffmpeg.sh &
        echo "started ffpmeg.."
	printf "%s - Started ffmpeg..\n" "$(date)" >> stream.log
        echo "Waiting 15 secs"
        sleep 15
    else
        echo "Stream looks ok."
    fi

    # limita la dimensione del file di log a 1mb
    size=$(du -b ${HOME}/ffmpeg.log | awk '{print $1}')
    if [ $size -gt 1048576 ]
    then
        tail -n 5000 ${HOME}/ffmpeg.log > ${HOME}/ffmpeg.log
    fi

    sleep 2
done