$basepath = (Get-Item $PSScriptRoot).Parent.FullName

#resources
$resourcespath = Join-Path $basepath "resources"
$filepath = Join-Path $resourcespath "example_file.txt"
$hashpath = Join-Path $resourcespath "hash.sha256"

#counter
$counterpath = Join-Path $basepath "docs\counter.xml"

#validate hash
$filehash = Get-FileHash $filepath -Algorithm SHA256
$prevFileHash = Get-Content $hashpath

if ($prevFileHash -ne $filehash) {
    $filehash | Out-File $hashpath -Force
    "<pingdom_http_custom_check>`n`t<status>OK</status>`n`t<response_time>$((Get-Date).ToString("yyyyMMdd"))</response_time>`n</pingdom_http_custom_check>" | Set-Content -NoNewline -Path $counterpath -Encoding ASCII
}