@echo off
echo BROKEN FILES ANALIZER
echo.
echo 1)SFC
echo 2)DISM
echo 3)CHKDSK
set /p num=

if %num% == 1 goto sfc
if %num% == 2 goto dism
if %num% == 3 goto chkdsk

:sfc
cls
sfc /scannow
pause
exit

:dism
cls
dism /online /cleanup-image /restorehealth
pause
exit

:chkdsk
cls
chkdsk
pause
exit

