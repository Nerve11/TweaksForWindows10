@echo off
color 0A
echo Starting Windows debloating process...
echo.


:: Fix PowerShell execution policy issue
echo Setting PowerShell execution policy to allow script execution...
powershell -command "Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force"
echo.


:: Stop Defender services
echo Stopping Defender services...
net stop WinDefend
net stop WdNisSvc
net stop SecurityHealthService
net stop Sense
echo.

:: Disable Defender services
echo Disabling Defender services permanently...
sc config WinDefend start= disabled
sc config WdNisSvc start= disabled
sc config SecurityHealthService start= disabled
sc config Sense start= disabled
echo.

:: Disable Defender via registry
echo Applying registry modifications to disable Defender...
:: Main Defender settings
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d 0 /f

:: Disable Real-time protection
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScriptScanning" /t REG_DWORD /d 1 /f

:: Disable scanning
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableArchiveScanning" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupFullScan" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupQuickScan" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableEmailScanning" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableCpuThrottleOnIdleScans" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableRemovableDriveScanning" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableRestorePoint" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningMappedNetworkDrivesForFullScan" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningNetworkFiles" /t REG_DWORD /d 1 /f

:: Disable MAPS/SpyNet
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /v "DisableBlockAtFirstSeen" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /v "LocalSettingOverrideSpynetReporting" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /v "SpynetReporting" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /v "SubmitSamplesConsent" /t REG_DWORD /d 2 /f

:: Disable file/folder exclusions and other settings
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Exclusions" /v "DisableAutoExclusions" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\NIS" /v "DisableProtocolRecognition" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" /v "MpCloudBlockLevel" /t REG_DWORD /d 0 /f

:: Disable Defender in Windows Security Center
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Virus & threat protection" /v "DisableNotifications" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Virus & threat protection" /v "UILockdown" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Account protection" /v "DisableNotifications" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Account protection" /v "UILockdown" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\App & browser protection" /v "DisableNotifications" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\App & browser protection" /v "UILockdown" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Device security" /v "DisableNotifications" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Device security" /v "UILockdown" /t REG_DWORD /d 1 /f

:: Disable Windows Security Center and notifications
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" /v "DisableNotifications" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" /v "DisableEnhancedNotifications" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /t REG_BINARY /d 030000000000000000000000 /f

:: Disable Tamper Protection 
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v "TamperProtection" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v "TamperProtectionSource" /t REG_DWORD /d 0 /f

:: Disable scheduled tasks for Defender
echo Disabling Windows Defender scheduled tasks...
schtasks /change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /disable
schtasks /change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /disable
schtasks /change /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /disable
schtasks /change /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /disable
schtasks /change /TN "Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh" /disable
schtasks /change /TN "Microsoft\Windows\Windows Defender\Windows Defender Remediation" /disable
schtasks /change /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Update" /disable
schtasks /change /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /disable
echo.

:: Remove Windows Defender from removal prevention
echo Modifying Windows Defender protection settings...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MsMpEng.exe" /v "Debugger" /t REG_SZ /d "taskkill.exe" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MsMpEngCP.exe" /v "Debugger" /t REG_SZ /d "taskkill.exe" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\NisSrv.exe" /v "Debugger" /t REG_SZ /d "taskkill.exe" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SecHealthUI.exe" /v "Debugger" /t REG_SZ /d "taskkill.exe" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SecurityHealthSystray.exe" /v "Debugger" /t REG_SZ /d "taskkill.exe" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SecurityHealthService.exe" /v "Debugger" /t REG_SZ /d "taskkill.exe" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MSASCuiL.exe" /v "Debugger" /t REG_SZ /d "taskkill.exe" /f
echo.

:: Remove Defender from Windows Security
echo Removing Defender from Windows Security...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /t REG_SZ /d "" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f


echo Removing default Windows applications...
powershell -command "Get-AppxPackage -allusers Microsoft.WindowsCamera | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers Microsoft.Microsoft3DViewer | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers Microsoft.MSPaint | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers Microsoft.OneDriveSync | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers Microsoft.People | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers Microsoft.ScreenSketch | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers Microsoft.WindowsMaps | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers Microsoft.WindowsSoundRecorder | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers Microsoft.YourPhone | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers Microsoft.ZuneMusic | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers Microsoft.ZuneVideo | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.WebpImageExtension* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.WebMediaExtensions* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.Print3D* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.HEIFImageExtension* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.XboxGamingOverlay* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *windowsstore* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *xboxapp* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers xbox | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers Microsoft.Xbox.TCUI | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers Microsoft.DesktopAppInstaller | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.SecHealthUI* | Remove-AppxPackage"

echo Removing additional applications
powershell -command "Get-AppxPackage -allusers *Microsoft.Getstarted* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.GetHelp* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.Messaging* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.Microsoft3DViewer* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.MixedReality.Portal* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.Office.OneNote* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.OneConnect* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.SkypeApp* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.Wallet* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.Windows.Photos* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.WindowsAlarms* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.WindowsCalculator* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.WindowsPhone* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.WindowsScan* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.BingNews* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.BingWeather* | Remove-AppxPackage"
powershell -command "Get-AppxPackage -allusers *Microsoft.GamingApp* | Remove-AppxPackage"
echo.

:: Fix for application data removal
echo Fixing application data removal...
powershell -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like '*Microsoft*'} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue"
echo.

:: Disable telemetry and data collection
echo Disabling telemetry and data collection...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
schtasks /end /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
schtasks /end /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable


:: Disable Full-screen Optimizations globally
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d 1 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d 1 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f

:: Disable Game Bar
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f

:: Optimize CPU priority for games
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f

:: Disable Windows Update (use with caution)
echo Disabling Windows Update services...
sc config wuauserv start= disabled
sc config UsoSvc start= disabled
sc config WaaSMedicSvc start= disabled
sc config bits start= disabled
sc config dosvc start= disabled
echo.

:: Performance Optimizations
echo Applying additional performance optimizations...
:: Disable visual effects
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f
:: Set high performance power plan
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
:: Disable Superfetch/SysMain service
sc config SysMain start= disabled
net stop SysMain
:: Disable Windows Search indexing
sc config WSearch start= disabled
net stop WSearch
echo.

:: Disable Cortana
echo Disabling Cortana...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f
echo.

:: Disable OneDrive
echo Disabling OneDrive...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f
taskkill /f /im OneDrive.exe
echo.

:: Clean up any remnants
echo Performing final cleanup...
del /f /q "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Windows Security.lnk" 2>nul
del /f /q "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Windows Security.lnk" 2>nul

:: Final message
echo ================================================
echo        WINDOWS DEBLOATING COMPLETED
echo ================================================
echo.
echo Press any key to restart your computer...
pause>nul
shutdown /r /t 10 /c "Restarting to apply system optimizations..."