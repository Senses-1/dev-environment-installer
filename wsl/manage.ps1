$wslRoot = Join-Path $env:USERPROFILE "WSL"

while ($true) {

    $distros = @(& "$PSScriptRoot\list.ps1")

    Write-Output ""
    Write-Output "Available WSL distributions:"
    Write-Output ""

    for ($i = 0; $i -lt $distros.Count; $i++) {
        Write-Output "[$($i + 1)] $($distros[$i])"
    }

    $createOption = $distros.Count + 1

    Write-Output "[$createOption] Create new WSL"
    Write-Output "[0] Exit"
    Write-Output ""

    $selection = Read-Host "Select option"

    $index = 0

    if (-not [int]::TryParse($selection, [ref]$index)) {
        Write-Error "Selection must be a number."
        continue
    }

    if ($index -eq 0) {
        exit 0
    }

    if ($index -lt 1 -or $index -gt $createOption) {
        Write-Error "Invalid selection."
        continue
    }

    # Create
    if ($index -eq $createOption) {

        $name = Read-Host "Enter new WSL name"

        if ([string]::IsNullOrWhiteSpace($name)) {
            Write-Error "WSL name cannot be empty."
            continue
        }

        $location = Join-Path $wslRoot $name

        & "$PSScriptRoot\create.ps1" `
            -Name $name `
            -Location $location

        continue
    }

    # Existing WSL
    $selectedDistro = $distros[$index - 1]

    Write-Output ""
    Write-Output "Selected: $selectedDistro"
    Write-Output ""
    Write-Output "[1] Open"
    Write-Output "[2] Remove"
    Write-Output "[0] Back"
    Write-Output ""

    $action = Read-Host "Select action"

    if ($action -eq "1") {

        & "$PSScriptRoot\open.ps1" `
            -Name $selectedDistro
    }
    elseif ($action -eq "2") {

        & "$PSScriptRoot\remove.ps1" `
            -Name $selectedDistro
    }
    elseif ($action -eq "0") {

        continue
    }
    else {

        Write-Error "Invalid action."
    }
}