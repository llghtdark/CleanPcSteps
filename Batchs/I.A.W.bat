@echo off

echo ===================
echo Internet
echo Accelerator for
echo Windows
echo ===================
echo.
echo WARNING: This will shutdown your Wifi Adaptor momentarily
pause

ipconfig /release

ipconfig /renew

ipconfig /flushdns

ipconfig /registerdns

nbtstat -rr

netsh int ip reset all

netsh winsock reset

exit