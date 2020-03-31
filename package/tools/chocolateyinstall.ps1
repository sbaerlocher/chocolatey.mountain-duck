# mountain-duck install

$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$PackageParameters = Get-PackageParameters
$urlPackage = "https://dist.mountainduck.io/Mountain%20Duck%20Installer-3.3.6.15539.msi"
$checksumPackage = "667add99d9439051bb2c78f9c617e452865a24a6581a877018bbbe2ac03fb7db350ad86bcecbe8e57b97cc40679831cb12d1921ffa6dd04e0f41f0c61eb5f791"
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
