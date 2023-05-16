C:\#servers\steamcmd\steamcmd.exe +force_install_dir C:\#servers\7days\ +login anonymous +app_update 294420 +quit
Set-Location C:\#servers\7days
timeout 3
xcopy C:\#Code\GameServers\7day\CFG\serverconfig.xml C:\#servers\7days /Y
timeout 3
@echo off

rem
rem Starts a dedicated server
rem
rem -quit, -batchmode, -nographics: Unity commands
rem -configfile			  : Allows server settings to be set up in an xml config file. Use no path if in same dir or full path.
rem -dedicated                    : Has to be the last option to start the dedicated server.

echo|set /p="251570" > steam_appid.txt

start C:\#servers\7days\7DaysToDieServer.exe -quit -batchmode -nographics -configfile=serverconfig.xml -dedicated

echo Wait until game started
timeout 15

echo.
echo Connect to the service interface. use 'shutdown' to stop the server
echo.
if exist "Tools/bin/putty.exe" (
     "Tools/bin/putty.exe" -raw localhost 8081
) else (
     telnet localhost 8081
)

echo.
echo Server is running in background, you can close this window
echo.

pause
