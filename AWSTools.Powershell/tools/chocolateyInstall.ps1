$params = @{
    packageName = 'AWSTools.Powershell'
    fileType = 'msi'
    silentArgs = '/quiet'
    url = 'http://sdk-for-net.amazonwebservices.com/latest/AWSToolsAndSDKForNet.msi'
}

Install-ChocolateyPackage @params
