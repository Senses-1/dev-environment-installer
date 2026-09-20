param(
    [Parameter(Mandatory = $true)]
    [string]$Name
)

$distros = @(& "$PSScriptRoot\list.ps1")

if ($Name -notin $distros) {
    Write-Error "WSL distribution '$Name' was not found."
    exit 1
}

wsl.exe --distribution $Name

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to open '$Name'."
    exit 1
}

exit 0