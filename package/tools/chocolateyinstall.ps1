# mountain-duck install

$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$PackageParameters = Get-PackageParameters
$urlPackage = "https://dist.mountainduck.io/Mountain%20Duck%20Installer-3.1.2.14611.msi"
$checksumPackage = "0b2fce1a26e639aeda8b8c44ee93c68b8e8ae036c6defa11becb48591da4f928daf143c5e22c9e2fa8979dc00f4f680d1afa4d4f28be1862844fc69964e7e8c7"
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
