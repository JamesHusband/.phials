using module RegistryEntry
using module TestCommandExists
using module SendMessage

$env:PSModulePath = "$PSHOME/Modules\" + ";$SCRIPTS_DIR/os/windows/modules";

#
# ░█▀▀░█▀▀░█▀█░█▀█░█▀█░░░█▀█░█▀█░█▀█░█▀▀
# ░▀▀█░█░░░█░█░█░█░█▀▀░░░█▀█░█▀▀░█▀▀░▀▀█
# ░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░░░░░▀░▀░▀░░░▀░░░▀▀▀
#
## 
# Install scoop
##
if (!(Test-Path -Path "$($env:USERPROFILE)/scoop/shims/scoop" -PathType Leaf)) {
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
}
else {
    Write-Host ""
    Write-Message -Type WARNING -Message "Scoop already installed. skipping..."
}

if (Test-CommandExists scoop) {
    
    # buckets
    $scoop_buckets = @(
        'main', 'extras', 'versions'
    )

    foreach ($bucket in $scoop_buckets) {
        scoop bucket add $bucket
    }

    # scoops
    $scoop_apps = @(
        'sudo', 'bat', 'btop', 'fastfetch', 'pshazz', 'vcredist',
        'secureuxtheme', '7tsp', 'archwsl', 'topgrade', 'via'
    )

    foreach ($app in $scoop_apps) {
        scoop install $app
    }

    # elevated installs
    sudo scoop install windowsdesktop-runtime-lts
}
else {
    Write-Message -Type WARNING  -Message "    Scoop not installed. Skipping scoop installs..."
}

#
# ░█░█░▀█▀░█▀█░█▀▀░█▀▀░▀█▀░░░█▀█░█▀█░█▀█░█▀▀
# ░█▄█░░█░░█░█░█░█░█▀▀░░█░░░░█▀█░█▀▀░█▀▀░▀▀█
# ░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░░▀░░░░▀░▀░▀░░░▀░░░▀▀▀
#
##
# Install winget
# https://github.com/microsoft/winget-cli/
##
if ( !(Test-CommandExists winget)) {
    Write-Host ""
    Write-Message  -Message "Installing winget"
    $download_url = "https://github.com/microsoft/winget-cli/releases/download/v1.4.10173/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    $download_save_file = "$($env:USERPROFILE)\Downloads\MicrosoftDesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    $wc.Downloadfile($download_url, $download_save_file)
    Add-AppXPackage -Path $($env:USERPROFILE)\Downloads\MicrosoftDesktopAppInstaller_8wekyb3d8bbwe.msixbundle
}
else {
    Write-Host ""
    Write-Message -Type WARNING  -Message "Winget already installed. Skipping..."
}

##
# Winget installations
##
if (Test-CommandExists winget) {
    $winget_apps = @(
        'Microsoft.PowerToys',
        'Microsoft.VisualStudioCode'
        'Microsoft.WindowsTerminal.Preview'
        'Microsoft.Powershell.Preview'
        'Git.Git',
        'Microsoft.DotNet.SDK.7',
        'Microsoft.DotNet.Runtime.7',
        'Microsoft.DotNet.DesktopRuntime.7',
        'Mozilla.Firefox',
        'AntibodySoftware.WizTree'
        'Microsoft.Sysinternals.Autoruns'
        'Valve.Steam',
        'Discord.Discord'
    )

    foreach ($app in $winget_apps) {
        Write-Message -Message "    Installing $app..."
        winget install --accept-package-agreements --accept-source-agreements --silent --no-upgrade --id $app
    }
}
else {
    Write-Message -Type WARNING -Message "    Winget not installed. Skipping winget installs..."
}

