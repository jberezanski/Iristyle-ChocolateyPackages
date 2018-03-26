import-module au

function global:au_SearchReplace {
    # nothing to update:
    # - the url is constant
    # - the checksum is not included in the package, so that the package still works
    #   after AWS releases a new version but before the package gets updated
    @{
    }
}

function global:au_GetLatest {
    $url = 'https://sdk-for-net.amazonwebservices.com/latest/AWSToolsAndSDKForNet.msi'
    $info = Invoke-WebRequest -Uri $url -UseBasicParsing -Method HEAD
    $fileName = $info.Headers['Content-Disposition'] -split '=' | Where-Object { $_ -match '\.msi$' }

    # AWSToolsAndSDKForNet_sdk-3.3.253.1_ps-3.3.245.0_tk-1.14.1.6.msi
    $rxPsVersion = [regex]'ps-(?<v>\d[\d\.]+\d)'
    $match = $rxPsVersion.Match($fileName)
    if (-not $match.Success) {
        throw "Failed to extract PS module version out of MSI file name: $fileName"
    }

    $psVersion = [version]$match.Groups['v'].Value
    return @{
        Version = $psVersion
    }
}

update -ChecksumFor none
