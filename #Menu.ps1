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
        # If text was given as an operand, it'll be an array.
        # Like Write-Host, we flatten the array into a single string
        # using simple string interpolation (which defaults to separating elements with a space,
        # which can be changed by setting $OFS).
        if ($Text -ne $null) {
            $Text = "$Text"
        }
    }

    process {
        if ($Text) {

            # Start with the foreground and background color specified via
            # -ForegroundColor / -BackgroundColor, or the current defaults.
            $curFgColor = $ForegroundColor
            $curBgColor = $BackgroundColor

            # Split message into tokens by '#'.
            # A token between to '#' instances is either the name of a color or text to write (in the color set by the previous token).
            $tokens = $Text.split("#")

            # Iterate over tokens.            
            $prevWasColorSpec = $false
            foreach($token in $tokens) {

                if (-not $prevWasColorSpec -and $token -match '^([a-z]+)(:([a-z]+))?$') { # a potential color spec.
                    # If a token is a color spec, set the color for the next token to write.
                    # Color spec can be a foreground color only (e.g., 'green'), or a foreground-background color pair (e.g., 'green:white')
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
                    # A text token: write with (with no trailing line break).
                    # !! In the ISE - as opposed to a regular PowerShell console window,
                    # !! $host.UI.RawUI.ForegroundColor and $host.UI.RawUI.ForegroundColor inexcplicably 
                    # !! report value -1, which causes an error when passed to Write-Host.
                    # !! Thus, we only specify the -ForegroundColor and -BackgroundColor parameters
                    # !! for values other than -1.
                    $argsHash = @{}
                    if ([int] $curFgColor -ne -1) { $argsHash += @{ 'ForegroundColor' = $curFgColor } }
                    if ([int] $curBgColor -ne -1) { $argsHash += @{ 'BackgroundColor' = $curBgColor } }
                    Write-Host -NoNewline @argsHash $token
                }

                # Revert to default colors.
                $curFgColor = $ForegroundColor
                $curBgColor = $BackgroundColor

            }
        }
        # Terminate with a newline, unless suppressed
        if (-not $NoNewLine) { write-host }
    }
}

xcopy C:\#Code\GameServers\V-Rising\Batch\*.ps1 C:\#servers\ /Y 
xcopy C:\#Code\GameServers\NOS\Batch\*.ps1 C:\#servers\ /Y 
xcopy C:\#Code\GameServers\Frozen\Batch\*.ps1 C:\#servers\ /Y 
xcopy C:\#Code\GameServers\7day\Batch\*.ps1 C:\#servers\ /Y 
timeout 3

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
Write-HostColored  " #blue# 7.#) #magenta#Core Keeper# Server."
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
        timeout 2
        ./V-Rising.ps1
        exit
       }
    3 {
        Clear-Host
        Write-HostColored "Launching #green#Ark Server# + Cluster + Updates."
        timeout 2
        ./Ark.bat
        exit
           }
    4 {
        Clear-Host
        Write-HostColored "Launching #green#7Days to die Server# + Updates."
        timeout 2
        ./7days.ps1
        exit
           }
    5 {
        Clear-Host
        Write-HostColored "Launching #green#Frozen Flames Server# + Updates."
        timeout 2
        ./Frozen.ps1
        exit
      }  
    6 {
        Clear-Host
        Write-HostColored "Launching #green#Craftopia Server# + Updates."
        timeout 2
        ./craftopia.bat
        exit
      }  
    7 {
        Clear-Host
        Write-HostColored "Launching #green#Core-Keeper Server# + Updates."
        timeout 2
        ./Core-Keeper.bat
        exit
      }
    8 {
        Clear-Host
        Write-HostColored "Launching #green#Insurgency Sandstorm Server# + Updates."
        timeout 2
        ./Insurgency.bat
        exit
      }  
    9 {
        Clear-Host
        Write-HostColored "Launching #green#Valheim Server# + Updates."
        timeout 2
        ./Valheim.ps1
        exit
      }
    10 {
        Clear-Host
        Write-HostColored "Launching #green#The Forest Server# + Updates."
        timeout 2
        ./the-forest.ps1
        exit
      } 
    11 {
        Clear-Host
        Write-HostColored "Launching #green#Rust Server# + Updates."
        timeout 2
        ./rust.ps1
        exit
      }    
    12 {
        Clear-Host
        Write-HostColored "Launching #green#No One Survived Server# + Updates."
        timeout 2
        ./No-one-survived.ps1
        exit
      }         
    }
}
    While ($Select -ne 0)
