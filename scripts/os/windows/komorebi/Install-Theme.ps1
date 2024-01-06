using module SendMessage

#
# ░▀█▀░█░█░█▀▀░█▄█░▀█▀░█▀█░█▀▀
# ░░█░░█▀█░█▀▀░█░█░░█░░█░█░█░█
# ░░▀░░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀
#
# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}

# # Windows themes variables
$RESOURCES = "C:\Windows\Resources\Themes\"
$objShell = New-Object -ComObject Shell.Application

# Loop through provided input directories
for ( $i = 0; $i -lt $args.count; $i++ ) {
    # Current directory being checked
    $Path = $($args[$i])
    
    Write-Message -Message " Installing $Path"

    Copy-Item -Path $Path -Destination $RESOURCES -Recurse -Force

    Write-Message -Type SUCCESS -Message "Successfully installed theme."
}

# # if needed
# $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
# New-Item $regPath -Force | Out-Null
# New-ItemProperty $regPath -Name NoThemesTab -Value 0 -Force | Out-Null
if (Test-Path -Path "$RESOURCES\Catppuccin-Mocha.theme" -PathType Leaf) {
    $currentTheme = (Get-ItemProperty -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\ -Name "CurrentTheme").CurrentTheme
    if ($currentTheme -eq "$RESOURCES\Catppuccin-Mocha.theme") {
        Write-Message -Type WARNING -Message "Theme already set to Catppuccin Mocha. Skipping..."
    }
    else {
        Write-Message -Message "Setting theme to Catppuccin Mocha"
        Start-Process -FilePath "$RESOURCES\Catppuccin-Mocha.theme"
        Start-Sleep -Seconds 3
        Stop-Process -Name "systemsettings.exe" -Force
        Write-Message -Message "Theme applied successfully."
    }
}
else {
    Write-Message -Type ERROR -Message "Catppuccin Mocha not found in $RESOURCES\. Skipping..."
}
