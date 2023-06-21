C:\#servers\steamcmd\steamcmd.exe +force_install_dir C:\#servers\DoD\ +login anonymous +app_update 232290 +quit
Set-Location C:\#servers\DoD
timeout 3
#xcopy C:\#Code\GameServers\7day\CFG\serverconfig.xml C:\#servers\7days /Y
#xcopy C:\#Code\GameServers\7day\CFG\serveradmin.xml C:\#servers\#Save\7Days\Save-Data /Y
#timeout 3
#C:\#servers\7days\7DaysToDieServer.exe -quit -batchmode -nographics -SaveGameFolder=C:\#servers\#Save\7Days\Save-Data -configfile=serverconfig.xml -dedicated
#SaveGameFolder

