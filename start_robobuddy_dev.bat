cd "C:\Program Files\Oracle\VirtualBox"
start VirtualBox.exe
start VBoxManage startvm "robobuddy" --type headless
timeout /t 10 /nobreak >nul
set ip="192.168.56.8"

:ping
ping -n 1 %ip% >nul
if %errorlevel% == 0 goto cygwin_ssh
timeout /t 2 /nobreak >nul
goto ping

:cygwin_ssh
timeout /t 20 /nobreak >nul
cd "C:\%HOMEPATH%\Desktop"
.\ssh_sessions.bat %ip%

rem VBoxManage controlvm robobuddy acpipowerbutton