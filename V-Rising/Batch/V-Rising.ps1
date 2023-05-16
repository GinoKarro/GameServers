xcopy C:\#Code\GameServers\V-Rising\CFG\* C:\#servers\v-rising\VRisingServer_Data\StreamingAssets\Settings\ /Y
timeout 5 
C:\#servers\steamcmd\steamcmd.exe +force_install_dir C:\#servers\v-rising\ +login anonymous +app_update 1829350 +quit
timeout 5 
Clear-Host
Write-Output "Starting V Rising Dedicated Server on port : 9876,9877 - PRESS CTRL-C to exit"
C:\#servers\v-rising\VRisingServer.exe -persistentDataPath C:\#servers\#Save\v-rising\save-data -serverName "-=QC PVE=- Virgin Tusk Rising" -saveName "TuskGG" -logFile "C:\#servers\#Save\v-rising\logs\VRisingServer.log"
