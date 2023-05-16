If (Test-Path -Path C:\#servers\Steamcmd\steamcmd.exe ) {
   Write-Host "SteamCMD Already installed." -NoNewline
}else {
  #Download
  set-location C:\#servers\Steamcmd\
  $url = "https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip"
  $destination = "C:\#servers\Steamcmd\steamcmd.zip"
  # Download the file
  Invoke-WebRequest -Uri $url -OutFile $destination
  # Unzip
  Add-Type -AssemblyName System.IO.Compression.FileSystem
  function Unzip
  {
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
  }

  Unzip "C:\#servers\Steamcmd\steamcmd.zip" "C:\#servers\Steamcmd\"
}
Remove-Item -Path C:\#servers\Steamcmd\steamcmd.zip -Force
Set-Location C:\#Code\GameServers
git pull origin main
timeout 2
xcopy C:\#Code\GameServers\#Menu.ps1 C:\#servers\ /Y
timeout 3
C:\#servers\#Menu.ps1
