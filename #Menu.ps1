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

Set-Location C:\#servers
Clear-Host
$MainMenu = {
Write-HostColored "#cyan# ***************************#"
Write-HostColored "#cyan# *   Server Starter Menu   *#"
Write-HostColored "#cyan# ***************************#"
Write-HostColored " #blue# 0.#) #red#Exit Menu.#"
Write-HostColored " #blue# 1.#) #yellow#Install new Server#."
Write-HostColored  " #blue# 2.#) #green#V-Rising# Server."
Write-HostColored  " #blue# 3.#) #magenta#Ark# Server."
Write-HostColored  " #blue# 4.#) #green#7DaysToDie# Server."
Write-HostColored  " #blue# 5.#) #magenta#Frozen Flames# Server."
Write-HostColored  " #blue# 6.#) #green#Craftopia# Server."
Write-HostColored  " #blue# 7.#) #magenta#Day of Defeat Source# Server."
Write-HostColored  " #blue# 8.#) #green#Insurgency Sandstorm# Server."
Write-HostColored  " #blue# 9.#) #magenta#Valheim# Server."
Write-HostColored  "#blue# 10.#) #green#The Forest# Server."
Write-HostColored  "#blue# 11.#) #magenta#Rust# Server."
Write-HostColored  "#blue# 12.#) #green#NoOneSurvived# Server."
Write-Host
Write-HostColored "#blue# Select the server you want to start#: "  -nonewline
}
Clear-Host
Do {
Clear-Host
Invoke-Command $MainMenu
$Select = Read-Host
Switch ($Select)
    {
    1 {
        Clear-Host
        Write-HostColored "Launching #green#New Server #installation."
        timeout 2
        ./Install-new-instance.ps1
        exit
       }
    2 {
        Clear-Host
        Write-HostColored "Launching #green#V-Rising Server# + Updates."
        xcopy C:\#Code\GameServers\V-Rising\Batch\*.ps1 C:\#servers\ /Y 
        timeout 3
        ./V-Rising.ps1
        exit
       }
    3 {
        Clear-Host
        Write-HostColored "Launching #green#Ark Server# + Cluster + Updates."
        xcopy C:\#Code\GameServers\ark\Batch\*.ps1 C:\#servers\ /Y
        timeout 3
        ./Ark.ps1
        exit
           }
    4 {
        Clear-Host
        Write-HostColored "Launching #green#7Days to die Server# + Updates."
        xcopy C:\#Code\GameServers\7day\Batch\*.ps1 C:\#servers\ /Y 
        timeout 3
        ./7days.ps1
        exit
           }
    5 {
        Clear-Host
        Write-HostColored "Launching #green#Frozen Flames Server# + Updates."
        xcopy C:\#Code\GameServers\Frozen\Batch\*.ps1 C:\#servers\ /Y 
        timeout 3
        ./Frozen.ps1
        exit
      }  
    6 {
        Clear-Host
        Write-HostColored "Launching #green#Craftopia Server# + Updates."
        timeout 3
        ./craftopia.bat
        exit
      }  
    7 {
        Clear-Host
        Write-HostColored "Launching #green#Day of Defeat Source Server# + Updates."
        timeout 3
        ./DoD.ps1
        exit
      }
    8 {
        Clear-Host
        Write-HostColored "Launching #green#Insurgency Sandstorm Server# + Updates."
        timeout 3
        ./Insurgency.bat
        exit
      }  
    9 {
        Clear-Host
        Write-HostColored "Launching #green#Valheim Server# + Updates."
        timeout 3
        ./Valheim.ps1
        exit
      }
    10 {
        Clear-Host
        Write-HostColored "Launching #green#The Forest Server# + Updates."
        timeout 3
        ./the-forest.ps1
        exit
      } 
    11 {
        Clear-Host
        Write-HostColored "Launching #green#Rust Server# + Updates."
        timeout 3
        ./rust.ps1
        exit
      }    
    12 {
        Clear-Host
        Write-HostColored "Launching #green#No One Survived Server# + Updates."
        xcopy C:\#Code\GameServers\NOS\Batch\*.ps1 C:\#servers\ /Y 
        timeout 3
        ./No-one-survived.ps1
        exit
      }         
    }
}
    While ($Select -ne 0)
