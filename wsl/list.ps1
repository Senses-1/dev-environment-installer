$previousEncoding = [Console]::OutputEncoding

try {
    [Console]::OutputEncoding = [System.Text.Encoding]::Unicode

    $distros = @(wsl.exe --list --quiet)

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to get WSL distributions. Exit code: $LASTEXITCODE"
    }

    $distros
}
finally {
    [Console]::OutputEncoding = $previousEncoding
}