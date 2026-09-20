param (
	[Parameter(Mandatory = $true)]
	[string]$Name
)

$distros = @(& "PSScriptRoot\list.ps1")

if ($Name -in $distros) {
	Write-Error "WSL distribution '$Name' already exists."
	exit 1
}

wsl.exe --install Debian --name $Name --no-launch

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to create WSL distribution '$Name'."
    exit 1
}

Write-Output "WSL distribution '$Name' created successfully."

exit 0