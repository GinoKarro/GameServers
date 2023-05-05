C:\#servers\steamcmd\steamcmd.exe +force_install_dir C:\#servers\v-rising\ +login anonymous +app_update 1829350 +quit
timeout 5
xcopy C:\#servers\v-rising\#Edit\bu\*.* C:\#servers\v-rising\VRisingServer_Data\StreamingAssets\Settings\ /Y
timeout 5 
cls
echo "Starting V Rising Dedicated Server on port : 9876,9877 - PRESS CTRL-C to exit"
C:\#servers\v-rising\VRisingServer.exe -persistentDataPath .\v-rising\save-data -serverName "-=QC PVE=- Virgin Rising" -saveName "TuskWorld" -logFile ".\v-rising\logs\VRisingServer.log"