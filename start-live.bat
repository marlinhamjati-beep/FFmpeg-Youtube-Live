@echo off
setlocal

REM Load config
for /f "usebackq tokens=1,2 delims=:" %%A in ("config.json") do (
    set "%%A=%%B"
)

REM Trim quotes & spaces
set "STREAM_KEY=%stream_key:~1,-1%"
set "VIDEO_PATH=%video_path:~1,-1%"

REM Loop live jika video_loop true
:START
ffmpeg -re -stream_loop -1 -i "%VIDEO_PATH%" -c:v libx264 -preset veryfast -b:v 2500k -c:a aac -b:a 128k -f flv "rtmp://a.rtmp.youtube.com/live2/%STREAM_KEY%"
pause

