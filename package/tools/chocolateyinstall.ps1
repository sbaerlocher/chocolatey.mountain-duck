# mountain-duck install

$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$PackageParameters = Get-PackageParameters
$urlPackage = "https://dist.mountainduck.io/Mountain%20Duck%20Installer-3.3.7.15567.msi"
$checksumPackage = "3a447a32bf88e7c2785aa39b1b55c961e46c922cfc7b93de8ddf44a9376fa39a8e1815cf48bf58d5bcd7ccbff347d4e559732dd2f8add44393247b6b1303cf8a"
$checksumTypePackage = 'SHA512'

Import-Module -Name "$($toolsDir)\helpers.ps1"

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'MSI'
    url            = $urlPackage
    checksum       = $checksumPackage
    checksumType   = $checksumTypePackage
    silentArgs     = '/quiet'
    validExitCodes = @(0, 1000, 1101)
}

Install-ChocolateyPackage @packageArgs

if ($PackageParameters.CleanStartmenu) {
    Remove-FileItem `
        -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Mountain Duck"
    Install-ChocolateyShortcut `
        -ShortcutFilePath "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Mountain Duck.lnk" `
        -TargetPath "C:\Program Files (x86)\Mountain Duck\Mountain Duck.exe" `
        -WorkDirectory "C:\Program Files (x86)\Mountain Duck\"
}
