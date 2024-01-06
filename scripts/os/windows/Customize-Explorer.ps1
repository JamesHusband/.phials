using module SendMessage
using module RegistryEntry

#
# ░▀█▀░█░█░█▀▀░█▄█░▀█▀░█▀█░█▀▀
# ░░█░░█▀█░█▀▀░█░█░░█░░█░█░█░█
# ░░▀░░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀
#
##
# Update Windows Taskbar
##
$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

# Show file extensions in explorer
Write-Message -Message "Setting View Settings for Explorer"
Set-RegistryEntry -Key 'HideFileExt' -Type "DWORD" -Value '0' -Path $RegPath
Set-RegistryEntry -Key 'Hidden' -Type "DWORD" -Value '1' -Path $RegPath

Stop-Process -Name explorer -Force
Start-Process explorer