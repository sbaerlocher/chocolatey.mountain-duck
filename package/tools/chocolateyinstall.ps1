# mountain-duck install

$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$PackageParameters = Get-PackageParameters
$urlPackage = "https://dist.mountainduck.io/Mountain%20Duck%20Installer-3.3.4.15443.msi"
$checksumPackage = "5573E86948EBC4014DEC7EEED370A2D51B5ABDDEB35B36B6F8AF92397B800EB0BB6D19DA323133EB1DEB8A7C2D80BCBF84C4C0BFF7428CA7B1D4D1878377159D"
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
