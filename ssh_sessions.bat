set ip=%1
echo %ip%
start C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico -p -1927,0 -w max -e /bin/ssh -t berners@%ip% "bash --login"
start C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico -p 0,0 -w max -e /bin/ssh -t berners@%ip% "bash --login"
rem start C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico -p -6,0 -s 347,53 -e /bin/ssh -t berners@%ip% "bash --login"