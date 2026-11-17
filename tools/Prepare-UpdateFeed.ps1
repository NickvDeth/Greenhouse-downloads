param(
    [Parameter(Mandatory=$true)][string]$FeedPath,
    [Parameter(Mandatory=$true)][string]$InstallerPath,
    [Parameter(Mandatory=$true)][string[]]$MetadataPaths
)
# Prepares a local feed only. Publish the verified release assets before merging it.
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression,System.IO.Compression.FileSystem
$feed = Get-Content -LiteralPath $FeedPath -Raw | ConvertFrom-Json
$products = @{
    'greenhouse-proxy' = @{Tag='proxy-v';Name='Greenhouse-Proxy';Platforms=@('windows-anycpu')}
    'greenhouse-backup' = @{Tag='backup-v';Name='Greenhouse-Backup';Platforms=@('windows-x64')}
    'greenhouse-plc-updater' = @{Tag='plc-updater-v';Name='Greenhouse-PLC-Updater';Platforms=@('windows-anycpu')}
    'greenhouse-vnc' = @{Tag='vnc-windows-v';Name='Greenhouse-VNC';Platforms=@('windows-x64','windows-arm64')}
}
if ($feed.schemaVersion -notin @(1,2) -or !$products.ContainsKey($feed.appId)) { throw 'Unknown feed.' }
$feed.schemaVersion = 2
$product = $products[$feed.appId]
$seen = @{}
$version = $null
$installer = Get-Item -LiteralPath $InstallerPath
$setupHash = (Get-FileHash -LiteralPath $installer.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
foreach ($path in $MetadataPaths) {
    $platform = [IO.Path]::GetFileName($path) -replace '^files\.', '' -replace '\.json$', ''
    if ($product.Platforms -notcontains $platform -or $seen.ContainsKey($platform)) { throw 'Unexpected/duplicate platform.' }
    $seen[$platform] = $true
    $metadata = Get-Content -LiteralPath $path -Raw | ConvertFrom-Json
    if ($metadata.version -cnotmatch '^[0-9]+\.[0-9]+\.[0-9]+$') { throw 'Invalid version.' }
    if ($version -and $metadata.version -ne $version) { throw 'Platform versions differ.' }
    $version = $metadata.version
    if ([version]$version -le [version]$feed.platforms.$platform.version) { throw 'Release must be newer than the public feed.' }
    $expectedInstaller = 'Setup-' + $product.Name + '-' + $version + '.exe'
    if ($installer.Name -cne $expectedInstaller) { throw 'Installer does not match release.' }
    if ($installer.VersionInfo.ProductVersion.Trim() -cne $version) { throw 'Installer resource version mismatch.' }
    $releaseUrl = 'https://github.com/NickvDeth/Greenhouse-downloads/releases/download/' + $product.Tag + $version + '/'
    if (@($metadata.files).Count -lt 2) { throw 'Missing update files.' }
    $fileNames = @{}
    foreach ($file in $metadata.files) {
        if ($file.path -cnotmatch '^[A-Za-z0-9][A-Za-z0-9._-]*$' -or $fileNames.ContainsKey($file.path)) { throw 'Invalid/duplicate file name.' }
        $fileNames[$file.path]=$true
        if ($file.sha256 -cnotmatch '^[a-f0-9]{64}$' -or $file.archiveSha256 -cnotmatch '^[a-f0-9]{64}$') { throw 'Invalid checksum.' }
        $asset = 'update-' + $file.archiveSha256 + '.zip'
        if ($file.url -cne ($releaseUrl + $asset)) { throw 'Archive URL mismatch.' }
        $archive = Join-Path ([IO.Path]::GetDirectoryName((Resolve-Path -LiteralPath $path).Path)) $asset
        if ((Get-Item -LiteralPath $archive).Length -ne $file.archiveSize -or (Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash -ine $file.archiveSha256) { throw 'Archive bytes mismatch.' }
        $zip = [IO.Compression.ZipFile]::OpenRead($archive)
        try {
            if ($zip.Entries.Count -ne 1 -or $zip.Entries[0].FullName -cne 'payload' -or $zip.Entries[0].Length -ne $file.size) { throw 'Unexpected payload.' }
            $stream = $zip.Entries[0].Open()
            $sha = [Security.Cryptography.SHA256]::Create()
            try { $hash = [BitConverter]::ToString($sha.ComputeHash($stream)).Replace('-','').ToLowerInvariant() }
            finally { $stream.Dispose(); $sha.Dispose() }
            if ($hash -cne $file.sha256) { throw 'Uncompressed bytes mismatch.' }
        } finally { $zip.Dispose() }
    }
    $feed.platforms.$platform = [ordered]@{version=$version; downloadUrl=($releaseUrl+$expectedInstaller); sha256=$setupHash; bytes=$installer.Length; files=@($metadata.files)}
}
if ($seen.Count -ne $product.Platforms.Count) { throw 'Missing architecture metadata.' }
$destination = (Resolve-Path -LiteralPath $FeedPath).Path
$temporary = Join-Path ([IO.Path]::GetDirectoryName($destination)) ('.signed-feed-' + [guid]::NewGuid().ToString('N') + '.json')
try {
    [IO.File]::WriteAllText($temporary,($feed | ConvertTo-Json -Depth 15) + [Environment]::NewLine,[Text.UTF8Encoding]::new($false))
    & (Join-Path $PSScriptRoot 'Sign-UpdateFeed.ps1') -FeedPath $temporary
    [IO.File]::Replace($temporary,$destination,[NullString]::Value)
} finally {
    if (Test-Path -LiteralPath $temporary) { Remove-Item -LiteralPath $temporary -Force }
}
Write-Host ('Prepared ' + $feed.appId + ' ' + $version + '. Publish the installer and every referenced ZIP before merging this feed.')
