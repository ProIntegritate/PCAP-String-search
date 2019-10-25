@echo off
echo y | del t.hex
echo y | del t.txt
echo y | del results.hex
echo y | del results.txt

echo %2 >t.txt

rem 12 = hexstream
rem 8 = hexbytes, for earlier versions of tshark (space separated bytes)
certutil -f -encodehex t.txt t.hex 12

set /p HEX=<t.hex
set HEX=%HEX:~0,-6%
tshark -r %1 -T fields -e data "data" | find /i "%HEX%" >results.hex
certutil -f -decodehex results.hex results.txt
notepad results.txt
