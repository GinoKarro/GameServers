C:\#servers\steamcmd\steamcmd.exe +force_install_dir C:\#servers\Ark\Server1 +login anonymous +app_update 376030 +quit
timeout 3
C:\#servers\steamcmd\steamcmd.exe +force_install_dir C:\#servers\Ark\Server2 +login anonymous +app_update 376030 +quit
mkdir C:\#servers\Ark\Cluster\MyFuckedUpCluster12333
timeout 5 
#xcopy C:\#Code\GameServers\Ark\CFG\* C:\#servers\v-rising\VRisingServer_Data\StreamingAssets\Settings\ /Y
timeout 5
Clear-Host
C:\#servers\Ark\Server1\ShooterGame\Binaries\Win64\ShooterGameServer.exe Ragnarok?listen?SessionName=-=Qc Fr=- Ragnarok Tusk Ark PVE?ServerPassword=12333?ServerAdminPassword=Ginette12?Port=27017?QueryPort=27018?MaxPlayers=100?AltSaveDirectoryName=C:\#servers\Ark\Cluster\Server1\ -NoTransferFromFiltering -clusterid=MyFuckedUpCluster12333 -ClusterDirOverride=C:\#servers\Ark\Cluster\MyFuckedUpCluster12333
C:\#servers\Ark\Server2\ShooterGame\Binaries\Win64\ShooterGameServer.exe CrystalIsles?listen?SessionName=-=Qc Fr=- CrystalIsle Tusk Ark PVE?ServerPassword=12333?ServerAdminPassword=Ginette12?Port=27019?QueryPort=27020?MaxPlayers=100?AltSaveDirectoryName=C:\#servers\Ark\Cluster\Server2\ -NoTransferFromFiltering -clusterid=MyFuckedUpCluster12333 -ClusterDirOverride=C:\#servers\Ark\Cluster\MyFuckedUpCluster12333