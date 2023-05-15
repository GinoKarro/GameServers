#    #Set Dated Backups
#    $date = (Get-Date).tostring("yyyyMMdd")
#    $hour = (Get-Date).tostring("hhmmss")
#    $save = 'NOS_' + $date + '_' + $hour + '_Backups'
#    
#    #Compress config
#    $compress = @{
#      Path = "C:\#servers\nos\WRSH\Saved\SaveGames"
#      CompressionLevel = "Fastest"
#      DestinationPath = "C:\#servers\Backup\No-One-Survived\SaveGames\$save.zip"
#    }
#    #Compress
#    Compress-Archive @compress -force -verbose

#Update Server VIA SteamCMD
C:\#servers\steamcmd\steamcmd.exe +force_install_dir C:\#servers\NOS\ +login anonymous +app_update 2329680 validate +quit
Timeout /T 10

#Copy Config Files to Server Folder
Copy-item -Path 'C:\#Code\GameServers\NOS\CFG\*.ini' -destination 'C:\#servers\NOS\WRSH\Saved\Config\WindowsServer\' -Recurse -force -verbose
Timeout /T 10

#Start NOS Server
C:\#servers\NOS\WRSHServer.exe -server -log
Timeout /T 10
