start /D "C:\Program Files\Oracle\VirtualBox" VBoxManage startvm "beastyboi" --type headless

:ping
ping -n 1 beastyboi >nul
if %errorlevel% == 0 goto done
sleep 2
goto ping

:done
exit 0
