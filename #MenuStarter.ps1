Set-Location C:\#Code\GameServers
git pull origin main
timeout 2
xcopy C:\#Code\GameServers\#Menu.ps1 C:\#servers\ /Y
timeout 3
C:\#servers\#Menu.ps1
