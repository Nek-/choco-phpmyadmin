$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$pp = Get-PackageParameters

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = 'https://files.phpmyadmin.net/phpMyAdmin/5.2.2/phpMyAdmin-5.2.2-all-languages.zip'

  softwareName  = 'phpmyadmin'

  checksum      = '6b99534f72ffb1d7275f50d23ca4141e1495c97d7cadb73a41d6dc580ed5ce29'
  checksumType  = 'sha256'
}

$basename = $packageArgs.url.Substring($packageArgs.url.LastIndexOf("/") + 1)
$basename = $basename -replace ".zip$", ""

$newInstallLocation = $packageArgs.Destination = GetInstallLocation $packageArgs.packageName $pp
$newInstallLocationTmp = "$($newInstallLocation)-tmp"

# This will print the destination folder at the complete end of the process
Install-ChocolateyZipPackage @packageArgs # https://chocolatey.org/docs/helpers-install-chocolatey-zip-package

# Trick recommanded in the mailing list of chocolatey to remove zip folder
Move-Item -Path "$($newInstallLocation)\$($basename)\" -Destination $newInstallLocationTmp
Remove-Item $newInstallLocation -Recurse
Move-Item -Path $newInstallLocationTmp -Destination $newInstallLocation


# Adding start binary (will launch php a php server)
New-Item -ItemType "directory" -Path "$newInstallLocation\bin"
Copy-Item -Path "$toolsDir\phpmyadmin.bat" -Destination "$newInstallLocation\bin\phpmyadmin.bat"
Install-BinFile -Name phpmyadmin -Path "$newInstallLocation\bin\phpmyadmin.bat"

# Set a default configuration for phpMyAdmin
$phpmyadminConfig = "$newInstallLocation\config.inc.php"
Copy-Item -Path "$newInstallLocation\config.sample.inc.php" -Destination $phpmyadminConfig
$randomString = -join ((65..90) + (97..122) | Get-Random -Count 32 | % {[char]$_})
"`$cfg['blowfish_secret'] = '$randomString';" | Out-File -Encoding utf8 -Append -FilePath $phpmyadminConfig
"`$cfg['Servers'][`$i]['AllowNoPassword'] = true;" | Out-File -Encoding utf8 -Append -FilePath $phpmyadminConfig
