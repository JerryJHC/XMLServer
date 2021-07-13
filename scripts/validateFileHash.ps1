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

if ($prevFileHash -ne $filehash.Hash) {
    $today = (Get-Date).ToString("HHmm.dd")
    $filehash.Hash | Set-Content -NoNewline -Path $hashpath
    "<pingdom_http_custom_check>`n`t<status>OK</status>`n`t<response_time>$today</response_time>`n`t<message>Modified $today</message>`n</pingdom_http_custom_check>" | Set-Content -NoNewline -Path $counterpath -Encoding ASCII
    git commit -a -m "modified counter check value to $today"
    git push
}