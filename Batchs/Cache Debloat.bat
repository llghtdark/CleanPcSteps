@echo off
color a
echo ---------------------
echo  Cache Debloat Start
echo ---------------------
pause>null

del /s /f /q %userprofile%\Recent\*.*

del /s /f /q C:\Windows\Prefetch\*.*

del /s /f /q C:\Windows\Temp\*.*

del /s /f /q %USERPROFILE%\appdata\local\temp\*.*

del null