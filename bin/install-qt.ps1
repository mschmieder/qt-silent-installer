param(
    [String] $PackageList,
    [String] $InstallDir,
    [String] $User,
    [String] $Password
)

Write-Host "#########################################"
Write-Host "QT SILENT INSTALLER"
Write-Host "#########################################"
Write-Host "->   Packages          = ${PackageList}"
Write-Host "->   Install Directory = ${InstallDir}"
Write-Host "->   User              = ${QT_USER}"
Write-Host "->   Password          = ${QT_PASSWORD}"


$installerUrl = "http://download.qt.io/official_releases/online_installers/qt-unified-windows-x86-online.exe"
$qtUnifiedInstaller = "c:/temp/qt-unified-windows-x86-online.exe"

New-Item -ItemType Directory -Force -Path c:/temp

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest ${installerUrl} -OutFile ${qtUnifiedInstaller} -UseBasicParsing

cp $PSScriptRoot/../install_qt_silent.qs.in install_qt_silent.qs

(Get-Content ./install_qt_silent.qs).replace('{{QT_PACKAGE_LIST}}', $PackageList) | Set-Content ./install_qt_silent.qs
(Get-Content ./install_qt_silent.qs).replace('{{QT_INSTALL_DIR}}', $InstallDir) | Set-Content ./install_qt_silent.qs
(Get-Content ./install_qt_silent.qs).replace('{{QT_USER}}', $User) | Set-Content ./install_qt_silent.qs
(Get-Content ./install_qt_silent.qs).replace('{{QT_PASSWORD}}', $Login) | Set-Content ./install_qt_silent.qs

# run installer
Start-Process $qtUnifiedInstaller -ArgumentList "--verbose --script ${pwd}/install_qt_silent.qs" -NoNewWindow -Wait