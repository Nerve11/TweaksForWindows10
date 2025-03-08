@echo off
color C
echo.


:: Boot configuration optimizations
echo Applying boot optimizations...
bcdedit /timeout 0
bcdedit /set hypervisorlaunchtype off
bcdedit /set bootux disabled
bcdedit /set quietboot yes
bcdedit /set {globalsettings} custom:16000067 true
bcdedit /set {globalsettings} custom:16000068 true
bcdedit /set {globalsettings} custom:16000069 true
bcdedit /set bootmenupolicy standard
bcdedit /set tscsyncpolicy Enhanced
bcdedit /set tpmbootentropy ForceDisable
bcdedit /set nx OptIn
bcdedit /set disabledynamictick yes
bcdedit /set useplatformtick yes
bcdedit /set usefirmwarepcisettings No
bcdedit /set disabledynamictick yes
bcdedit /set useplatformclock No
bcdedit /set debug No
bcdedit /set isolatedcontext No
bcdedit /set noumex Yes
bcdedit /set vsmlaunchtype Off
bcdedit /set vm No

:: Disable unnecessary services
echo Disabling unnecessary services...
sc config "DiagTrack" start= disabled
sc config "dmwappushservice" start= disabled
sc config "RetailDemo" start= disabled
sc config "diagnosticshub.standardcollector.service" start= disabled
sc config "diagsvc" start= disabled
sc config "WerSvc" start= disabled
sc config "DPS" start= disabled
sc config "SysMain" start= disabled
sc config "PcaSvc" start= disabled
sc config "WSearch" start= disabled
sc config "BITS" start= demand
sc config "DusmSvc" start= disabled
sc config "MapsBroker" start= disabled
sc config "Spooler" start= disabled
sc config "workfolderssvc" start= disabled
sc config "ndu" start= disabled
sc config "wscsvc" start= disabled

:: Disable scheduled tasks for telemetry collection
echo Disabling telemetry collection tasks...
schtasks /Change /TN "Microsoft\Windows\Device Setup\Metadata Refresh" /Disable
schtasks /Change /TN "Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /Disable
schtasks /Change /TN "Microsoft\Windows\International\Synchronize Language Settings" /Disable
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdates" /Disable
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /Disable
schtasks /Change /TN "Microsoft\Windows\InstallService\SmartRetry" /Disable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable
schtasks /Change /TN "Microsoft\Windows\UPnP\UPnPHostConfig" /Disable
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /Disable
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /Disable
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Work" /Disable
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /Disable
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Report policies" /Disable
schtasks /Change /TN "Microsoft\Windows\StateRepository\MaintenanceTasks" /Disable
schtasks /Change /TN "Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTask" /Disable
schtasks /Change /TN "Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTaskNetwork" /Disable
schtasks /Change /TN "Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTaskLogon" /Disable
schtasks /Change /TN "Microsoft\Windows\Device Information\Device" /disable
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /disable
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /disable
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /disable
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /disable
schtasks /Change /TN "Microsoft\Windows\Shell\IndexerAutomaticMaintenance" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /disable
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /disable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefreshTask" /Disable
schtasks /Change /TN "Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner" /Disable
schtasks /Change /TN "Microsoft\Windows\Diagnosis\Scheduled" /Disable
schtasks /Change /TN "Microsoft\Windows\User Profile Service\HiveUploadTask" /Disable
schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Disable
schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /Disable
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable
schtasks /Change /TN "Microsoft\Windows\BrokerInfrastructure\BgTaskRegistrationMaintenanceTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Chkdsk\ProactiveScan" /Disable
schtasks /Change /TN "Microsoft\Windows\Registry\RegIdleBackup" /Disable
schtasks /Change /TN "Microsoft\Windows\Defrag\ScheduledDefrag" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskFootPrint\StorageSense" /Disable
schtasks /Change /TN "Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser" /Disable
schtasks /Change /TN "Microsoft\Windows\Wininet\CacheTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsToastTask" /disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /disable
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Scheduled Start" /disable
schtasks /Change /TN "Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /Disable
schtasks /Change /TN "Microsoft\Windows\Time Synchronization\SynchronizeTime" /Disable
schtasks /Change /TN "Microsoft\Windows\Time Zone\SynchronizeTimeZone" /Disable
schtasks /Change /TN "Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents" /disable
schtasks /Change /TN "Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic" /disable
schtasks /Change /TN "Microsoft\Windows\Windows Filtering Platform\BfeOnServiceStartTypeChange" /disable
schtasks /Change /TN "Microsoft\Windows\DiskCleanup\SilentCleanup" /disable
schtasks /Change /TN "\Microsoft\Windows\Ras\MobilityManager" /disable
schtasks /Change /TN "\Microsoft\Windows\RetailDemo\CleanupOfflineContent" /disable
schtasks /Change /TN "Microsoft\Windows\Chkdsk\ProactiveScan" /disable
schtasks /Change /TN "Microsoft\Windows\Chkdsk\SyspartRepair" /disable
schtasks /Change /TN "Microsoft\Windows\Data Integrity Scan\Data Integrity Scan" /disable
schtasks /Change /TN "Microsoft\Windows\Data Integrity Scan\Data Integrity Check And Scan" /disable
schtasks /Change /TN "Microsoft\Windows\Data Integrity Scan\Data Integrity Scan for Crash Recovery" /disable
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" /disable

:: Network optimizations
echo Applying network optimizations...
netsh interface tcp set global autotuninglevel=normal
netsh interface tcp set global ecncapability=disabled
netsh advfirewall firewall add rule name="StopThrottling" dir=in action=block remoteip=173.194.55.0/24,206.111.0.0/16 enable=yes
netsh int tcp set global chimney=enabled
netsh int tcp set global dca=enabled
netsh int tcp set global netdma=enabled
netsh int tcp set global ecncapability=disabled
netsh int tcp set global rss=enabled
netsh int tcp set supplemental custom congestionprovider=ctcp

:: Gaming optimizations (from AtlasOS and ReviOS)
echo Applying gaming optimizations...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Affinity /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Background Only /t REG_SZ /d False /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Clock Rate /t REG_DWORD /d 10000 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v GPU Priority /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Scheduling Category /t REG_SZ /d High /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v SFIO Priority /t REG_SZ /d High /f

:: Disable Game DVR/Game Bar for better performance
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\GameBar" /v UseNexusForGameBarEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v value /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f

:: SapphireOS-inspired memory optimizations
echo Optimizing RAM settings...
for /f "tokens=2 delims==" %%a in ('wmic os get TotalVisibleMemorySize /format:value') do set mem=%%a
set /a ram=%mem% + 1024000
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "%ram%" /f


:: Disable HPET (High Precision Event Timer) for lower latency
echo Disabling HPET for better latency...
bcdedit /deletevalue useplatformclock

:: Disable unnecessary Windows features
echo Disabling unnecessary Windows features...
dism /online /disable-feature /featurename:WindowsMediaPlayer /NoRestart
dism /online /disable-feature /featurename:Internet-Explorer-Optional-amd64 /NoRestart
dism /online /disable-feature /featurename:WCF-Services45 /NoRestart
dism /online /disable-feature /featurename:WCF-TCP-PortSharing45 /NoRestart
dism /online /disable-feature /featurename:MediaPlayback /NoRestart
dism /online /disable-feature /featurename:WindowsMediaPlayer /NoRestart
dism /online /disable-feature /featurename:WCF-TCP-PortSharing45 /NoRestart
dism /online /disable-feature /featurename:WCF-Services45 /NoRestart
dism /online /disable-feature /featurename:SMB1Protocol /NoRestart
dism /online /disable-feature /featurename:Printing-XPSServices-Features /NoRestart

:: Remove GameBarPresenceWriter.exe (known to cause performance issues)
echo Removing GameBarPresenceWriter.exe...
takeown /f "%WinDir%\System32\GameBarPresenceWriter.exe" /a
del "%WinDir%\System32\GameBarPresenceWriter.exe" /s /f /q

:: Remove telemetry components
echo Removing telemetry components...
takeown /f "%SystemRoot%\System32\CompatTelRunner.exe" /r /d y
del "%SystemRoot%\System32\CompatTelRunner.exe" /s /f /q

:: Disable Process Mitigations (improves performance)
echo Disabling Process Mitigations...
PowerShell set-ProcessMitigation -System -Disable  DEP, EmulateAtlThunks, SEHOP, ForceRelocateImages, RequireInfo, BottomUp, HighEntropy, StrictHandle, DisableWin32kSystemCalls, AuditSystemCall, DisableExtensionPoints, BlockDynamicCode, AllowThreadsToOptOut, AuditDynamicCode, CFG, SuppressExports, StrictCFG, MicrosoftSignedOnly, AllowStoreSignedBinaries, AuditMicrosoftSigned, AuditStoreSigned, EnforceModuleDependencySigning, DisableNonSystemFonts, AuditFont, BlockRemoteImageLoads, BlockLowLabelImageLoads, PreferSystem32, AuditRemoteImageLoads, AuditLowLabelImageLoads, AuditPreferSystem32, EnableExportAddressFilter, AuditEnableExportAddressFilter, EnableExportAddressFilterPlus, AuditEnableExportAddressFilterPlus, EnableImportAddressFilter, AuditEnableImportAddressFilter, EnableRopStackPivot, AuditEnableRopStackPivot, EnableRopCallerCheck, AuditEnableRopCallerCheck, EnableRopSimExec, AuditEnableRopSimExec, SEHOP, AuditSEHOP, SEHOPTelemetry, TerminateOnError, DisallowChildProcessCreation, AuditChildProcess

:: Disable DMA Remapping (improves I/O performance)
echo Disabling DMA Remapping...
for %%a in (DmaRemappingCompatible DmaRemappingCompatibleSelfhost) do for /f "delims=" %%b in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /s /f "%%a" ^| findstr "HKEY"') do reg.exe add "%%b" /v "%%a" /t REG_DWORD /d "0" /f > NUL 2>&1

:: Disable inking and typing data collection
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f

:: Disable mouse acceleration for better gaming precision
echo Disabling mouse acceleration for better gaming precision...
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f

:: Enable game mode
reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "1" /f

:: Set processor scheduling for programs
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "38" /f

:: Disable prefetch and Superfetch
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f

:: Disable UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f

:: Optimize Windows Explorer
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f

:: Delete temporary files
echo Deleting temporary files...
del /s /f /q %WinDir%\Temp\*.*
del /s /f /q %TEMP%\*.*
del /s /f /q %AppData%\Temp\*.*

echo.
echo.
echo A restart is required to apply all changes.
echo Press any key to restart computer now...
pause > nul
shutdown /r /t 5 /c "Restarting to apply Windows tweaks"

exit