C:\#servers\steamcmd\steamcmd.exe +force_install_dir C:\#servers\Frozen\ +login anonymous +app_update 1348640 validate +quit
timeout 3
xcopy C:\#Code\GameServers\Frozen\CFG\*.ini C:\#servers\frozen\FrozenFlame\Saved\Config\WindowsServer\ /Y
C:\#servers\frozen\FrozenFlameServer.exe -log -LOCALLOGTIMES -MetaGameServerName="-=°Qc|Fr°=- Tusken Flame Server" -ip=0.0.0.0 -Port=27018 -queryPort=27019 -RconPort=25575 -RconPassword=ginette12 -noeac
