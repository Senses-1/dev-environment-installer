param(
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$Location
)

$distros = @(& "$PSScriptRoot\list.ps1")

if ($Name -in $distros) {
    Write-Error "WSL distribution '$Name' already exists."
    exit 1
}

if (Test-Path $Location) {
    Write-Error "Location '$Location' already exists."
    exit 1
}

Write-Output "Creating WSL:"
Write-Output "Name: $Name"
Write-Output "Location: $Location"

wsl.exe --install Debian `
    --name $Name `
    --location $Location `
    --no-launch

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to create WSL distribution '$Name'."
    exit 1
}

Write-Output "WSL distribution '$Name' created."

exit 0