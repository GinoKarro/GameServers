C:\#servers\steamcmd\steamcmd.exe +force_install_dir C:\#servers\7days\ +login anonymous +app_update 294420 +quit
Set-Location C:\#servers\7days
timeout 3
xcopy C:\#Code\GameServers\7day\CFG\serverconfig.xml C:\#servers\7days /Y
xcopy C:\#Code\GameServers\7day\CFG\serveradmin.xml C:\#servers\#Save\7Days\Save-Data /Y
timeout 3

& ./7DaysToDieServer.exe -quit -batchmode -nographics -SaveGameFolder=C:\#servers\#Save\7Days\Save-Data -configfile=serverconfig.xml -dedicated
#SaveGameFolder

