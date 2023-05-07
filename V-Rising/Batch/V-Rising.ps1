C:\#servers\steamcmd\steamcmd.exe +force_install_dir C:\#servers\v-rising\ +login anonymous +app_update 1829350 +quit
timeout 5
cd C:\#Code\GameServers
git pull origin main
timeout 5
xcopy C:\#Code\GameServers\V-Rising\CFG\*.* C:\#servers\v-rising\VRisingServer_Data\StreamingAssets\Settings\ /Y
xcopy C:\#Code\GameServers\V-Rising\Batch\V-Rising.ps1 C:\#servers\ /Y
timeout 5 
cls
echo "Starting V Rising Dedicated Server on port : 9878,9879 - PRESS CTRL-C to exit"
C:\#servers\v-rising\VRisingServer.exe -persistentDataPath .\v-rising\save-data -serverName "-=QC PVE=- Virgin Rising" -saveName "TuskWorld" -logFile ".\v-rising\logs\VRisingServer.log"
