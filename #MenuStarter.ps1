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
    Write-HostColored "#green#SteamCMD Already installed#." -NoNewline
    timeout 3
}else {
    #Download
    Clear-Host
    Write-HostColored "#green#SteamCMD is not installed#." -NoNewline
    timeout 3
    Clear-Host
    Write-HostColored "#green#Creating installation DIR#." -NoNewline
    timeout 3
    mkdir C:\#servers\Steamcmd\
    set-location C:\#servers\Steamcmd\
    Clear-Host
    Write-HostColored "#green#Downloading #red# SteamCMD#." -NoNewline
    timeout 3
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
    Write-HostColored "#green#Unzipping #red# SteamCMD#." -NoNewline
    timeout 3
    Unzip "C:\#servers\Steamcmd\steamcmd.zip" "C:\#servers\Steamcmd\"
}
##########################################################################################
Clear-Host
Write-HostColored "#green#Removing Archive of #red# SteamCMD.zip#." -NoNewline
timeout 3
Remove-Item -Path C:\#servers\Steamcmd\steamcmd.zip -Force  -ErrorAction SilentlyContinue
Clear-Host
Write-HostColored "#green#Updating #red# SteamCMD#." -NoNewline
timeout 3
start-process "C:\#Code\GameServers\UpdateSteamCMD.bat" -wait
Clear-Host
Write-HostColored "#green#Syncing #red# Github #green#files #." -NoNewline
timeout 3
Set-Location C:\#Code\GameServers
git pull origin main
timeout 3
Clear-Host
Write-HostColored "#green#Update #red# Menu Script #green#and then launch it #." -NoNewline
timeout 3
xcopy C:\#Code\GameServers\#Menu.ps1 C:\#servers\ /Y
C:\#servers\#Menu.ps1
