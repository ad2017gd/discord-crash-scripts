#!/bin/bash

rm converted.mp4 &2>nul
rm converted_noaudio.mp4 &2>nul

echo Downloading crash.h264
curl https://ad2017.xyz/s/crash.h264 --output crash.h264
echo Getting the raw h.264 stream from start.mp4
ffmpeg -i start.mp4 -vf scale=800:800,setsar=1:1 -aspect 1 -pix_fmt yuv411p -r 30 start.h264
echo Extracting the audio from start.mp4
ffmpeg -i start.mp4 audio.mp3
echo Concatenating the 2 streams
cat start.h264 crash.h264 > raw.h264
echo Finishing the video
ffmpeg -i raw.h264 -c copy -metadata title="ad2017.xyz/crash" -pix_fmt yuv420p converted_noaudio.mp4
ffmpeg -i converted_noaudio.mp4 -i audio.mp3 -c copy -map 0:v -map 1:a -metadata title="ad2017.xyz/crash" -pix_fmt yuv420p converted.mp4
echo Created.

rm crash.h264
rm start.h264
rm audio.mp3
rm raw.h264
#rm converted_noaudio.mp4

