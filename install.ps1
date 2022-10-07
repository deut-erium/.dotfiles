function Check-Fix-DOM-Errors {
    Try {
        $testReq = Invoke-WebRequest -Uri "https://google.com"
    }
    catch [System.NotSupportedException] {
        #https://stackoverflow.com/questions/38005341/the-response-content-cannot-be-parsed-because-the-internet-explorer-engine-is-no
        #for DOM parsing errors
        Invoke-WebRequest -UseBasicParsing -Uri "https://c2rsetup.officeapps.live.com/c2r/downloadEdge.aspx?platform=Default&source=EdgeStablePage&Channel=Stable&language=en"  -OutFile "MicrosoftEdgeSetup.exe"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Value 2
    }
}

function Install-Latest-Git {
    $gitinf="[Setup]
    Lang=default
    Dir=C:\Program Files\Git
    Group=Git
    NoIcons=0
    SetupType=default
    Components=ext,ext\shellhere,ext\guihere,gitlfs,assoc,assoc_sh,windowsterminal
    Tasks=
    EditorOption=VIM
    CustomEditorPath=
    DefaultBranchOption= 
    PathOption=Cmd
    SSHOption=OpenSSH
    TortoiseOption=false
    CURLOption=OpenSSL
    CRLFOption=CRLFAlways
    BashTerminalOption=MinTTY
    GitPullBehaviorOption=Merge
    UseCredentialManager=Enabled
    PerformanceTweaksFSCache=Enabled
    EnableSymlinks=Disabled
    EnablePseudoConsoleSupport=Enabled
    EnableFSMonitor=Enabled
    "
    $git_install_inf = "$env:temp\git_install.inf"
    echo $gitinf | Out-File -FilePath $git_install_inf
	$git_url = "https://api.github.com/repos/git-for-windows/git/releases/latest"
    $asset = Invoke-RestMethod -Method Get -Uri $git_url | % assets | where name -like "*64-bit.exe"
    # download installer
    $installer = "$env:temp\$($asset.name)"
    Write-Host "Downloading latest version "$asset.name"" 
    Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $installer
    # run installer
    $install_args = "/SP- /VERYSILENT /SUPPRESSMSGBOXES /NOCANCEL /NORESTART /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /LOADINF=""$git_install_inf"""
    Start-Process -FilePath $installer -ArgumentList $install_args -Wait
    Remove-Item $git_install_inf
    Remove-Item $installer
    Write-Host "Successfully installed "$asset.name"" -ForegroundColor Green
}

function Install-Latest-7zip {
    $7zipUri = "https://7-zip.org/"
    $latestVersion = Invoke-WebRequest -Uri $7zipUri | Select-Object -ExpandProperty Links | Where-Object {($_.innerHTML -eq 'Download') -and ($_.href -like "a/*") -and ($_.href -like "*-x64.exe")} | Select-Object -ExpandProperty href
    $webLocation = $7zipUri + $latestVersion
    $installer = "$env:temp\7zip-install.exe"
    Write-Host "Downloading latest version $latestVersion"
    Invoke-WebRequest -Uri $webLocation -Outfile $installer
    Start-Process -FilePath $installer -ArgumentList "/S" -Wait
    Write-Host "Successfully installed $latestVersion" -ForegroundColor Green
    Remove-Item $installer
}

function Install-Latest-SVN {
    $64bitVersions = Invoke-WebRequest -Uri "https://tortoisesvn.net/downloads.html" | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*x64*.msi*") -and ($_.class -eq "btn")}
    # should be latest version and LTS version
    # handling redirect
    $latestVersion = [System.Web.HttpUtility]::HtmlDecode("https://osdn.net"+(Invoke-WebRequest -Uri $64bitVersions[0].href | Select-Object -ExpandProperty Links | Where-Object {($_.href -like "*.msi")})[0].href)
    $installer = "$env:temp\svn.msi"
    Write-Host "Downloading latest SVN version"
    Invoke-WebRequest -Uri $latestVersion -Outfile $installer
    echo $installer
    Start-Process $installer -ArgumentList "/passive /norestart ADDLOCAL=ALL" -Wait
    Write-Host "Successfully installed 7zip" -ForegroundColor Green
    Remove-Item $installer
}

function Install-Python-And-Setup {
    $pythonUrl = "https://www.python.org/ftp/python/3.6.7/python-3.6.7-amd64.exe"
    $installer = "$env:temp\python3.6.7.exe"
    Write-Host "Downloading Python 3.6.7 Installer"
    Invoke-WebRequest -Uri $pythonUrl -Outfile $installer
	Write-Host "Disabling Path length limit"
	Set-ItemProperty 'HKLM:\System\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -value 1
    Write-Host "Installing Python"
	Start-Process $installer -ArgumentList "/quiet InstallAllUsers=1 TargetDir=""C:\Python3.6.7"" CompileAll=1 PrependPath=1 SimpleInstall=1" -Wait
	Start-Process C:\Python3.6.7\python.exe -ArgumentList "-m pip install pip==9.0.1" -Wait
	Remove-Item $installer
}

function EncryptStuff{
    param (
        $inputPath,
        $outputPath
    )
    $AESCipher = New-Object System.Security.Cryptography.AesCryptoServiceProvider
    $AESCipher.Key = [System.Convert]::FromBase64String("R29vZ2xlIGRyaXZlIHN1Y2tzISBCT09PT09PT09PISE=")
    $AESCipher.IV = [System.Convert]::FromBase64String("bW9yZSBib29vb29vISEhIQ==")
    $encryptor = $AESCipher.CreateEncryptor()
    $fileContents = [System.IO.File]::ReadAllBytes("$pwd\$inputPath")
    $encryptedContent = $encryptor.TransformFinalBlock($fileContents,0,$fileContents.Length)
    Set-Content $outputPath -Value $encryptedContent -Encoding Byte
    $AESCipher.Dispose()
}

function DecryptStuff{
    param (
        $inputPath,
        $outputPath
    )
    $AESCipher = New-Object System.Security.Cryptography.AesCryptoServiceProvider
    $AESCipher.Key = [System.Convert]::FromBase64String("R29vZ2xlIGRyaXZlIHN1Y2tzISBCT09PT09PT09PISE=")
    $AESCipher.IV = [System.Convert]::FromBase64String("bW9yZSBib29vb29vISEhIQ==")
    $decryptor = $AESCipher.CreateDecryptor()
    $fileContents = [System.IO.File]::ReadAllBytes("$pwd\$inputPath")
    $decryptedContent = $decryptor.TransformFinalBlock($fileContents,0,$fileContents.Length)
    Set-Content $outputPath -Value $decryptedContent -Encoding Byte
    $AESCipher.Dispose()
}

# Check-Fix-DOM-Errors
# Install-Latest-Git
# Install-Latest-7zip
# Install-Latest-SVN




