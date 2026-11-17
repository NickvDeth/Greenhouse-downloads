param(
    [string]$KeyDirectory = (Join-Path $env:LOCALAPPDATA 'Achterbosch\ReleaseSigning')
)
# Run once on the release maintainer's Windows account. Never write a plaintext private key.
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Security
$directory = [IO.Path]::GetFullPath($KeyDirectory)
if ($directory -notmatch '^[A-Za-z]:\\' -or ([IO.DriveInfo]::new($directory.Substring(0,3))).DriveType -ne [IO.DriveType]::Fixed) { throw 'Use a local fixed drive outside source control/cloud sync.' }
$check = $directory
while ($check) {
    if ((Test-Path -LiteralPath $check) -and ((Get-Item -LiteralPath $check -Force).Attributes -band [IO.FileAttributes]::ReparsePoint)) { throw 'Key directory cannot contain links.' }
    $check = [IO.Path]::GetDirectoryName($check)
}
if (Test-Path -LiteralPath (Join-Path $directory 'release-key.dpapi')) { throw 'A release key already exists; refusing to overwrite it.' }
$null = New-Item -ItemType Directory -Path $directory -Force
$acl = [Security.AccessControl.DirectorySecurity]::new()
$acl.SetAccessRuleProtection($true,$false)
foreach ($sid in @([Security.Principal.WindowsIdentity]::GetCurrent().User.Value,'S-1-5-18')) {
    $acl.AddAccessRule([Security.AccessControl.FileSystemAccessRule]::new([Security.Principal.SecurityIdentifier]::new($sid),'FullControl','ContainerInherit,ObjectInherit','None','Allow'))
}
[IO.Directory]::SetAccessControl($directory,$acl)
$rsa = [Security.Cryptography.RSACryptoServiceProvider]::new(4096)
$rsa.PersistKeyInCsp = $false
$privateBytes = $null
try {
    $privateBytes = [Text.Encoding]::UTF8.GetBytes($rsa.ToXmlString($true))
    $entropy = [Text.Encoding]::UTF8.GetBytes('Achterbosch.Greenhouse.ReleaseSigning.v1')
    $protected = [Security.Cryptography.ProtectedData]::Protect($privateBytes,$entropy,[Security.Cryptography.DataProtectionScope]::CurrentUser)
    [IO.File]::WriteAllBytes((Join-Path $directory 'release-key.dpapi'),$protected)
    $public = [ordered]@{keyId='greenhouse-release-2026-11';algorithm='RS256';publicKeyXml=$rsa.ToXmlString($false)}
    [IO.File]::WriteAllText((Join-Path $directory 'public-key.json'),($public | ConvertTo-Json),[Text.UTF8Encoding]::new($false))
    Write-Host ('Created a DPAPI-protected 4096-bit release key in ' + $directory)
    Write-Host 'Only public-key.json may be committed. Preserve access to this Windows profile and plan protected offline recovery before replacing this computer.'
} finally {
    if ($privateBytes) { [Array]::Clear($privateBytes,0,$privateBytes.Length) }
    $rsa.Dispose()
}
