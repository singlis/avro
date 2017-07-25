$source=".\packages"
$destination=".\packages\boost.1.64.0.0\lib\native\address-model-64"
$lib_dir_exists = Test-Path $destination
if ($lib_dir_exists) {
    Remove-Item $destination -Force -Recurse
    New-Item -ItemType directory -Path=$destination
} else {
    New-Item -ItemType directory -Path=$destination
}

$filter = [regex]"[^/]+\\address-model-64\\[^/]+$"
$bin = Get-ChildItem -rec | Where-Object {!$_.PSIsContainer} | ForEach-Object -Process {$_.FullName}
$filtered = $bin -match $filter
foreach ($item in $filtered) {
    Copy-Item -Path $item -Destination $destination
}
