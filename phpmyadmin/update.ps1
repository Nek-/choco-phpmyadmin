import-module au

$releases = 'https://www.phpmyadmin.net/downloads/'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1" = @{
          "(?i)(\s*url\s*=\s*)('.*')" = "`${1}'$($Latest.URL32)'"
          "(?i)(\s*checksum\s*=\s*)('.*')" = "`${1}'$($Latest.sha256)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(  phpMyAdmin:).*" = "`${1} <$($Latest.URL32)>"
          "(?i)(  checksum:).*" = "`${1} $($Latest.sha256)"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url = $download_page.links | ? href -match '\.zip' | % href | select -First 1
    $version = $url -split '/' | select -Last 1 -Skip 1

    $url_sha = $download_page.links | ? href -match '\.sha256' | % href | select -First 1
    $sha_page = Invoke-WebRequest -Uri $url_sha
    $sha256 = $sha_page.RawContent -split "\n" | select -Last 1 -Skip 1
    $sha256 = $sha256 -split ' ' | select -First 1

    @{
       URL32   = $url
       Version = $version
       sha256 = $sha256
    }
}

update -ChecksumFor none