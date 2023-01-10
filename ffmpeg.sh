#!/bin/sh

sleep 5
#Utente di sistema dove viene collocato lo script
USER="pi"
#Utente della telecamera che deve trasmettere il flusso RTSP
USERCAM="admin"
PASSCAM="passwordcamera"
#Percorso completo
HOME="/home/${USER}"

#L'url è diverso per ogni telecamera. Si prega di configurare questa parte con il proprio URL
RTSP_URL="rtsp://${USERCAM}:${PASSCAM}@192.168.1.90:554/1/h264major"

#Url youtube per inviare lo streaming
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"
#Token di youtube da inserire qui
YOUTUBE_KEY="xxxx-xxxx-xxxx-xxxx-xxxx"

ffmpeg -thread_queue_size 512 \
-use_wallclock_as_timestamps 1 \
-rtsp_transport tcp \
-i ${RTSP_URL} \
-i ${HOME}/audio.m4a \
-c:v copy \
-c:a copy \
-stream_loop -1 \
-f flv \
${YOUTUBE_URL}/${YOUTUBE_KEY} \
-pix_fmt yuv420p \
2> ${HOME}/ffmpeg.log
