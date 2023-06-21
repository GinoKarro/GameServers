
C:\#servers\steamcmd\steamcmd.exe +force_install_dir C:\#servers\DoD\ +login anonymous +app_update 232290 +quit
Set-Location C:\#servers\DoD
timeout 3
xcopy C:\#Code\GameServers\DoD\Config\server.cfg C:\#servers\DoD\dod\ /Y
#timeout 3
#C:\#servers\7days\7DaysToDieServer.exe -quit -batchmode -nographics -SaveGameFolder=C:\#servers\#Save\7Days\Save-Data -configfile=serverconfig.xml -dedicated
srcds.exe -console -game dod +port 27015 +map dod_anzio -autoupdate +maxplayers 32
#SaveGameFolder

