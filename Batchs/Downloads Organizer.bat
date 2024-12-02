@echo off
::CHANGELOG   v0.6//Latest
::configs
color a

 :main
cls
echo 1.Start Organizer
echo 2.Create Default Folders
echo 3.Open
echo 4.exit
set /p num=

if %num% == 2 goto defal
if %num% == 1 goto Org
if %num% == 3 goto Opener
if %num% == 4 exit

 :defal
cls
cd /
cd %USERPROFILE%/Downloads
md PHOTOS
md AUDIOS
md VIDEOS
md DOCS
md EXEC
md ZIP
echo Folders Created
pause
goto main

 :Org
cls
cd /
cd %USERPROFILE%/Downloads

::photos section
move *.png PHOTOS
move *.jpg PHOTOS
move *.jpeg PHOTOS
move *.svg PHOTOS
move *.gif PHOTOS
move *.jfif PHOTOS

::videos section
move *.mp4 VIDEOS
move *.wmv VIDEOS
move *.avi VIDEOS
move *.mpeg VIDEOS
move *.mkv VIDEOS
move *.webm VIDEOS
move *.mov VIDEOS

::pdf section
move *.pdf DOCS
move *.docx DOCS
move *.doc DOCS
move *.rtf DOCS
move *.txt DOCS

::audios section
move *.mp3 AUDIOS
move *.ogg AUDIOS
move *.wav AUDIOS

::executables section
move *.exe EXEC
move *.zip ZIP
move *.rar ZIP
move *.7z ZIP
move *.gz ZIP

echo MOST OF IT IS NOW ORGANIZED SIR
pause
goto main

 :Opener
cls
cd /
cd %USERPROFILE%/Downloads
echo Open?
echo.
echo 1.PHOTOS
echo 2.AUDIOS
echo 3.VIDEOS
echo 4.DOCS
echo 5.EXEC
echo 6.ZIP
set /p nim=

if %nim% == 1 start PHOTOS
if %nim% == 2 start AUDIOS
if %nim% == 3 start VIDEOS
if %nim% == 4 start DOCS
if %nim% == 5 start EXEC
if %nim% == 6 start ZIP
goto main

