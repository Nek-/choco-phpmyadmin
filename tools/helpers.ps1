
function GetInstallLocation  {
  param(
    [string]$PackageName,
    $pp
  )

  if ($pp -and $pp.InstallDir) {
    return $pp.InstallDir
  }

  $toolsLocation = Get-ToolsLocation
  return "$toolsLocation\{0}" -f $PackageName
}