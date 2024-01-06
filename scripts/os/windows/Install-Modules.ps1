using module SendMessage

# 
# ░█▀█░█▀▄░█▀▀░█▀█
# ░█▀▀░█▀▄░█▀▀░█▀▀
# ░▀░░░▀░▀░▀▀▀░▀░░
#
$DOTFILES_MODULES_PATH = "$SCRIPTS_DIR/os/windows/modules"
$DOCUMENTS_PATH = Get-ItemPropertyValue -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name "Personal" -ErrorAction SilentlyContinue
$USER_MODULES_PATH = "$DOCUMENTS_PATH/WindowsPowerShell/Modules/"

Write-Host $DOCUMENTS_PATH

# Check if the PowerShell directory exists, and if not, create it
if (-not (Test-Path -Path $USER_MODULES_PATH)) {
    New-Item -Path $USER_MODULES_PATH -ItemType Directory -Force
}

$ModuleList = Get-ChildItem -Path "$DOTFILES_MODULES_PATH\*"

foreach ( $module in $ModuleList ) {
    if (Get-ChildItem -Path "$DOCUMENTS_PATH/WindowsPowerShell/Modules/*" | Select-String -Pattern $module.baseName ) {
        Write-Message -Type WARNING -Message ( -join ($module.baseName, " already installed. Skipping..."))
    }
    else {
        Write-Message -Message ( -join ("Installing ", $module.baseName, " module"))
        Copy-Item -Path "$module" -Destination "$USER_MODULES_PATH" -Recurse -Force
    }
}
