# Define environment variables
$global:GIT_DIR = git rev-parse --show-toplevel
$manifestPath = Join-Path $GIT_DIR "envs/win/apps/manifest.yml"

# Function to parse YAML file
function ParseYaml($filePath) {
    $yamlContent = Get-Content -Raw -Path $filePath
    $yamlLines = $yamlContent -split "`n"

    $packages = @()
    foreach ($line in $yamlLines) {
        if ($line -match "^\s*-\s*(\S+)\s*$") {
            $packages += $matches[1]    
        }
    }

    return $packages
}

# Check if Chocolatey is installed
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey is not installed. Please install it first from https://chocolatey.org/install"
    exit 1
}

# Install applications from manifest.yml
if (Test-Path $manifestPath) {
    Write-Host "Reading package list from $manifestPath..."
    $appsToInstall = ParseYaml -filePath $manifestPath

    foreach ($app in $appsToInstall) {
        Write-Host "Installing $app via Chocolatey..."
        choco install $app -y --ignore-checksums
    }

    Write-Host "Installation complete."
}
else {
    Write-Host "Error: Manifest file not found at $manifestPath"
    exit 1
}