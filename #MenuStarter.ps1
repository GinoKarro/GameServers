###########################################################################################################
###Text Color module.

function Write-HostColored() {
    [CmdletBinding(ConfirmImpact='None', SupportsShouldProcess=$false, SupportsTransactions=$false)]
    param(
        [parameter(Position=0, ValueFromPipeline=$true)]
        [string[]] $Text
        ,
        [switch] $NoNewline
        ,
        [ConsoleColor] $BackgroundColor =  $host.UI.RawUI.BackgroundColor
        ,
        [ConsoleColor] $ForegroundColor = $host.UI.RawUI.ForegroundColor
    )

    begin {
        if ($Text -ne $null) {
            $Text = "$Text"
        }
    }

    process {
        if ($Text) {
            $curFgColor = $ForegroundColor
            $curBgColor = $BackgroundColor
            $tokens = $Text.split("#")          
            $prevWasColorSpec = $false
            foreach($token in $tokens) {

                if (-not $prevWasColorSpec -and $token -match '^([a-z]+)(:([a-z]+))?$') { 
                    try {
                        $curFgColor = [ConsoleColor]  $matches[1]
                        $prevWasColorSpec = $true
                    } catch {}
                    if ($matches[3]) {
                        try {
                            $curBgColor = [ConsoleColor]  $matches[3]
                            $prevWasColorSpec = $true
                        } catch {}
                    }
                    if ($prevWasColorSpec) {
                        continue                    
                    }
                }

                $prevWasColorSpec = $false

                if ($token) {
                    $argsHash = @{}
                    if ([int] $curFgColor -ne -1) { $argsHash += @{ 'ForegroundColor' = $curFgColor } }
                    if ([int] $curBgColor -ne -1) { $argsHash += @{ 'BackgroundColor' = $curBgColor } }
                    Write-Host -NoNewline @argsHash $token
                }
                $curFgColor = $ForegroundColor
                $curBgColor = $BackgroundColor

            }
        }
        if (-not $NoNewLine) { write-host }
    }
}
########################################################################################
### Start of Script.


If (Test-Path -Path C:\#servers\Steamcmd\steamcmd.exe ) {
    Clear-Host
    Write-HostColored " #cyan# SteamCMD Already installed # ." -NoNewline
    timeout 3
}else {
    #Download
    Clear-Host
    Write-HostColored "#cyan# SteamCMD is not installed # ." -NoNewline
    timeout 2
    Clear-Host
    Write-HostColored "#cyan# Creating installation DIR # ." -NoNewline
    mkdir C:\#servers\Steamcmd\
    set-location C:\#servers\Steamcmd\
    Clear-Host
    Write-HostColored "#cyan# Downloading #red# SteamCMD # ." -NoNewline
    timeout 2
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
    Clear-Host
    Write-HostColored "#cyan# Unzipping #red# SteamCMD # ." -NoNewline
    timeout 2
    Unzip "C:\#servers\Steamcmd\steamcmd.zip" "C:\#servers\Steamcmd\"
}
Clear-Host
Write-HostColored "#cyan# Removing Archive of #red# SteamCMD.zip # ." -NoNewline
timeout 2
Remove-Item -Path C:\#servers\Steamcmd\steamcmd.zip -Force  -ErrorAction SilentlyContinue
Clear-Host
Write-HostColored "#cyan# Updating #red# SteamCMD # ." -NoNewline
timeout 2
start-process "C:\#Code\GameServers\UpdateSteamCMD.bat" -wait
Clear-Host
Write-HostColored "#cyan# Syncing #red# Github #cyan# files  # ." -NoNewline
timeout 2
Set-Location C:\#Code\GameServers
git pull origin main
Clear-Host
Write-HostColored "#cyan# Update #red# Menu Script #cyan# and then launch it  # ." -NoNewline
timeout 2
xcopy C:\#Code\GameServers\#Menu.ps1 C:\#servers\ /Y
C:\#servers\#Menu.ps1
