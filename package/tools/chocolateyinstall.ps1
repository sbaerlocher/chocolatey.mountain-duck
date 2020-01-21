# mountain-duck install

$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$PackageParameters = Get-PackageParameters
$urlPackage = "https://dist.mountainduck.io/Mountain%20Duck%20Installer-3.3.4.15443.msi"
$checksumPackage = "196b421afde2c450ca0adab902ecb62cd380c15c7ba6d912b12b0be3ae2c549be380334f1dd8ec88b88a041a9fdbc158eb74bb596c6fc4c9e619d8168be72022"
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
