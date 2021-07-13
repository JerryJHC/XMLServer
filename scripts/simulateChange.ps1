$basepath = (Get-Item $PSScriptRoot).Parent.FullName

$filepath = Join-Path $basepath "resources\example_file.txt"

while ($true) {
    if ( (Get-Random -Minimum 1 -Maximum 10) -lt 5 ) {
        Get-Random | Set-Content -NoNewline -Path $filepath
        Start-Sleep -s 10
        Write-Host "Ini validate"
        Start-Process Powershell (Join-Path $PSScriptRoot "validateFileHash.ps1") -Wait
        Write-Host "End validate"
    }
    Start-Sleep -s 240
}