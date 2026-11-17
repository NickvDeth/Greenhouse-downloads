param(
    [Parameter(Mandatory=$true)][string]$FeedPath,
    [string]$KeyDirectory = (Join-Path $env:LOCALAPPDATA 'Achterbosch\ReleaseSigning')
)
# An independent local key signs exact UTF-8 bytes, never a reserialized JSON value.
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Security
$public = Get-Content -LiteralPath (Join-Path $PSScriptRoot 'release-public-key.json') -Raw | ConvertFrom-Json
$feed = Get-Content -LiteralPath $FeedPath -Raw | ConvertFrom-Json
if ($feed.schemaVersion -ne 1 -or $feed.appId -notin @('greenhouse-backup','greenhouse-proxy','greenhouse-plc-updater','greenhouse-vnc') -or !$feed.platforms) { throw 'Invalid feed.' }
$body = [ordered]@{
    schemaVersion=1; appId=$feed.appId; platforms=$feed.platforms
    signing=[ordered]@{purpose='greenhouse-windows-update';keyId=$public.keyId;issuedUtc=[DateTime]::UtcNow.ToString('o')}
}
$bytes = [Text.UTF8Encoding]::new($false).GetBytes(($body | ConvertTo-Json -Depth 15 -Compress))
if ($bytes.Length -gt 65536) { throw 'Signed payload is too large.' }
$rsa = [Security.Cryptography.RSACryptoServiceProvider]::new()
$rsa.PersistKeyInCsp = $false
$privateBytes = $null
try {
    $encrypted = [IO.File]::ReadAllBytes((Join-Path $KeyDirectory 'release-key.dpapi'))
    $entropy = [Text.Encoding]::UTF8.GetBytes('Achterbosch.Greenhouse.ReleaseSigning.v1')
    $privateBytes = [Security.Cryptography.ProtectedData]::Unprotect($encrypted,$entropy,[Security.Cryptography.DataProtectionScope]::CurrentUser)
    $rsa.FromXmlString([Text.Encoding]::UTF8.GetString($privateBytes))
    if ($rsa.KeySize -ne 4096 -or $rsa.ToXmlString($false) -cne $public.publicKeyXml) { throw 'Private signing key does not match the pinned public key.' }
    $signature = $rsa.SignData($bytes,'SHA256')
    if (!$rsa.VerifyData($bytes,'SHA256',$signature)) { throw 'Signature self-test failed.' }
    $envelope = [ordered]@{algorithm='RS256';keyId=$public.keyId;payload=[Convert]::ToBase64String($bytes);signature=[Convert]::ToBase64String($signature)}
    $feed | Add-Member -MemberType NoteProperty -Name signedManifest -Value $envelope -Force
    [IO.File]::WriteAllText((Resolve-Path -LiteralPath $FeedPath).Path,($feed | ConvertTo-Json -Depth 15) + [Environment]::NewLine,[Text.UTF8Encoding]::new($false))
    Write-Host ('Signed ' + $feed.appId + ' with ' + $public.keyId + '.')
} finally {
    if ($privateBytes) { [Array]::Clear($privateBytes,0,$privateBytes.Length) }
    $rsa.Dispose()
}
