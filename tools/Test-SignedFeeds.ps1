$ErrorActionPreference='Stop'
$public=Get-Content -LiteralPath (Join-Path $PSScriptRoot 'release-public-key.json') -Raw | ConvertFrom-Json
$rsa=[Security.Cryptography.RSACryptoServiceProvider]::new()
$rsa.PersistKeyInCsp=$false
try {
    $rsa.FromXmlString($public.publicKeyXml)
    if ($rsa.KeySize -ne 4096) { throw 'Unexpected release key size.' }
    foreach ($name in @('proxy','backup','plc-updater','vnc')) {
        $feed=Get-Content -LiteralPath (Join-Path $PSScriptRoot ('../updates/'+$name+'.json')) -Raw | ConvertFrom-Json
        $signed=$feed.signedManifest
        if (!$signed -or $signed.algorithm -cne 'RS256' -or $signed.keyId -cne $public.keyId) { throw ('Unsigned/untrusted feed: '+$name) }
        $payload=[Convert]::FromBase64String($signed.payload)
        if (!$rsa.VerifyData($payload,'SHA256',[Convert]::FromBase64String($signed.signature))) { throw ('Bad signature: '+$name) }
        $body=[Text.UTF8Encoding]::new($false,$true).GetString($payload) | ConvertFrom-Json
        if ($body.schemaVersion -ne 1 -or $body.appId -cne ('greenhouse-'+$name) -or $body.signing.purpose -cne 'greenhouse-windows-update' -or $body.signing.keyId -cne $public.keyId) { throw ('Bad signature context: '+$name) }
        if ($feed.schemaVersion -ne $body.schemaVersion -or $feed.appId -cne $body.appId -or ($feed.platforms | ConvertTo-Json -Depth 15 -Compress) -cne ($body.platforms | ConvertTo-Json -Depth 15 -Compress)) { throw ('Legacy metadata differs from signed metadata: '+$name) }
        foreach ($platform in $body.platforms.PSObject.Properties) {
            if (!$platform.Name.StartsWith('windows-')) { continue }
            $release=$platform.Value
            if ($release.version -cnotmatch '^\d+\.\d+\.\d+$' -or $release.sha256 -cnotmatch '^[a-f0-9]{64}$' -or !$release.files) { throw ('Incomplete Windows release: '+$name) }
            if ($release.downloadUrl -cnotmatch '^https://github\.com/NickvDeth/Greenhouse-downloads/releases/download/') { throw 'Unexpected installer origin.' }
            foreach ($file in $release.files) {
                if ($file.path -cnotmatch '^[A-Za-z0-9][A-Za-z0-9._-]*$' -or $file.sha256 -cnotmatch '^[a-f0-9]{64}$' -or $file.archiveSha256 -cnotmatch '^[a-f0-9]{64}$') { throw 'Invalid update entry.' }
                if ($file.url -cnotmatch '^https://github\.com/NickvDeth/Greenhouse-downloads/releases/download/' -or !$file.url.EndsWith('/update-'+$file.archiveSha256+'.zip')) { throw 'Unexpected update origin.' }
            }
        }
        Write-Host ('PASS: '+$name+' signed feed and legacy metadata agree.')
    }
} finally { $rsa.Dispose() }
