start /D "C:\Program Files\Oracle\VirtualBox" VBoxManage startvm "beastyboi" --type headless
cd \d "C:\cygwin64\bin"
run.exe -p /usr/X11R6/bin XWin -listen tcp -multiwindow -clipboard -silent-dup-error
