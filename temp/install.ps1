# Create folders
$folders = @(
    "Operating Systems/Linux/scripts",
    "Operating Systems/macOS/scripts",
    "Operating Systems/Windows/scripts",
    "Operating Systems/Linux/config",
    "Operating Systems/macOS/config",
    "Operating Systems/Windows/config",
    "Operating Systems/Linux/packages",
    "Operating Systems/macOS/packages",
    "Operating Systems/Windows/packages",
    "System/zsh configs",
    "System/git",
    "System/.ssh",
    "GPT/setup",
    "GPT/tools",
    "Modules/lib",
    "Modules/scripts",
    "Dev/hosts/host-generic",
    "Dev/hosts/host-linux",
    "Dev/hosts/host-macos",
    "Dev/hosts/host-win",
    "Dev/config",
    "Dev/config/editor",
    "Dev/config/terminal",
    "packages",
    "Dev/packages"
)

foreach ($folder in $folders) {
    New-Item -Path $folder -ItemType Directory -Force
}

# Initialize Git repository
git init

# Create README
Set-Content -Path "README.md" -Value "# Dotfile Repository"

# Add files to the repository
git add .

# Make initial commit
git commit -m "Initial commit"

Write-Host "Repository initialized and files committed!"