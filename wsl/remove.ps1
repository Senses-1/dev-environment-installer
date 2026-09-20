param(
	[Parameter(Mandatory = $true)]
	[string]$Name
)

$distros = @(& "$PSScriptRoot\list.ps1")

if ($Name -notin $distros) {
	Write-Error "WSL distribution '$Name' was not found"
	exit 1
}

$confirmation = Read-Host "Permanently delete '$Name'? [y/N]"

if ($confirmation -ne "y") {
    Write-Output "Cancelled."
    exit 0
}

wsl.exe --unregister $Name

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to remove '$Name'."
    exit 1
}

Write-Output "WSL distribution '$Name' removed."

exit 0