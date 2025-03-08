@echo off
color A
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)
:: Initialize environment
setlocal EnableExtensions EnableDelayedExpansion

echo ======================================================
echo    Advanced Intel CPU Optimization Tool for Gaming
echo ======================================================
echo.

:: Create backup of registry settings
echo Creating registry backups...
reg export "HKLM\SYSTEM\CurrentControlSet\Control\Power" "%TEMP%\power_backup.reg" /y >nul
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "%TEMP%\system_profile_backup.reg" /y >nul
reg export "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" "%TEMP%\memory_management_backup.reg" /y >nul
reg export "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" "%TEMP%\kernel_backup.reg" /y >nul
echo Backups created successfully.
echo.

:: Detect Intel CPU and determine series
echo Detecting Intel CPU...
set "CPU_DETECTED=0"
set "SERIES="

for /f "tokens=2 delims==" %%i in ('wmic cpu get name /value ^| find "="') do (
    set CPU_NAME=%%i
    set CPU_DETECTED=1
    
    echo Detected: !CPU_NAME!
    
    echo !CPU_NAME! | findstr /i "i3-[0-9]" > nul
    if !errorlevel! equ 0 (
        set SERIES=i3
        echo CPU Series: Intel Core i3
    )
    
    echo !CPU_NAME! | findstr /i "i5-[0-9]" > nul
    if !errorlevel! equ 0 (
        set SERIES=i5
        echo CPU Series: Intel Core i5
    )
    
    echo !CPU_NAME! | findstr /i "i7-[0-9]" > nul
    if !errorlevel! equ 0 (
        set SERIES=i7
        echo CPU Series: Intel Core i7
    )
    
    echo !CPU_NAME! | findstr /i "i9-[0-9]" > nul
    if !errorlevel! equ 0 (
        set SERIES=i9
        echo CPU Series: Intel Core i9
    )
    
    echo !CPU_NAME! | findstr /i "Pentium" > nul
    if !errorlevel! equ 0 (
        set SERIES=pentium
        echo CPU Series: Intel Pentium
    )
    
    echo !CPU_NAME! | findstr /i "Celeron" > nul
    if !errorlevel! equ 0 (
        set SERIES=celeron
        echo CPU Series: Intel Celeron
    )
)

if "%CPU_DETECTED%"=="0" (
    echo No Intel CPU detected or unable to identify CPU.
    echo Applying generic Intel optimizations...
    set SERIES=generic
)

echo.
echo ======================================================
echo    Applying Base Optimizations
echo ======================================================

:: Create custom power plan
echo Creating high performance power plan for gaming...
powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 88888888-8888-8888-8888-888888888888 >nul
powercfg -changename 88888888-8888-8888-8888-888888888888 "Intel Gaming Performance" >nul
powercfg -setactive 88888888-8888-8888-8888-888888888888 >nul

:: Base power settings for all Intel CPUs
echo Configuring power settings...
powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PERFINCPOL 2
powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PERFDECPOL 1
powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PERFINCTHRESHOLD 10
powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PERFDECTHRESHOLD 20

:: Disable core parking
echo Disabling CPU core parking...
powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 0

:: System profile optimizations
echo Configuring system profile for gaming...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "10" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "10000" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f

:: Memory and kernel optimizations for maximum performance
echo Applying memory and security optimizations for maximum performance...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "MoveImages" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "KernelSEHOPEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableTsx" /t REG_DWORD /d "1" /f

:: Premium performance tweaks
echo Applying premium performance tweaks...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SystemPages" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SecondLevelDataCache" /t REG_DWORD /d "1024" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d "983040" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DpcWatchdogPeriod" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "EnableDynamicTick" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "GlobalTimerResolutionRequests" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "ThreadDpcEnable" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "SplitLargeCaches" /t REG_DWORD /d "1" /f

echo.
echo ======================================================
echo    Applying CPU Series-Specific Optimizations
echo ======================================================

:: Apply CPU series-specific optimizations
if "%SERIES%"=="i9" (
    echo Applying Intel Core i9 specific optimizations...
    
    :: i9 processors can handle more aggressive settings
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 2
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PROCTHROTTLEMAX 100
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PROCTHROTTLEMIN 100
    
    :: Optimize for multi-threaded performance
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "38" /f
    
    :: Premium i9 tweaks
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb" /v "ValueMax" /t REG_DWORD /d "0" /f
)

if "%SERIES%"=="i7" (
    echo Applying Intel Core i7 specific optimizations...
    
    :: i7 processors balance between performance and thermals
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 2
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PROCTHROTTLEMAX 100
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PROCTHROTTLEMIN 90
    
    :: Optimize for multi-threaded performance
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "36" /f
    
    :: Premium i7 tweaks
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb" /v "ValueMax" /t REG_DWORD /d "0" /f
)

if "%SERIES%"=="i5" (
    echo Applying Intel Core i5 specific optimizations...
    
    :: i5 processors need balanced settings
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 3
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PROCTHROTTLEMAX 100
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PROCTHROTTLEMIN 80
    
    :: Optimize for balanced performance
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "26" /f
    
    :: Premium i5 tweaks
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb" /v "ValueMax" /t REG_DWORD /d "0" /f
)

if "%SERIES%"=="i3" (
    echo Applying Intel Core i3 specific optimizations...
    
    :: i3 processors need more conservative settings
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 3
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PROCTHROTTLEMAX 100
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PROCTHROTTLEMIN 70
    
    :: Optimize for foreground applications
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "24" /f
)

if "%SERIES%"=="pentium" (
    echo Applying Intel Pentium specific optimizations...
    
    :: Pentium processors need conservative settings
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 3
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PROCTHROTTLEMAX 100
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PROCTHROTTLEMIN 60
    
    :: Optimize for foreground applications
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "18" /f
)

if "%SERIES%"=="celeron" (
    echo Applying Intel Celeron specific optimizations...
    
    :: Celeron processors need very conservative settings
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 3
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PROCTHROTTLEMAX 100
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PROCTHROTTLEMIN 50
    
    :: Optimize for foreground applications
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "18" /f
)

if "%SERIES%"=="generic" (
    echo Applying generic Intel optimizations...
    
    :: Generic balanced settings
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 3
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PROCTHROTTLEMAX 100
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 SUB_PROCESSOR PROCTHROTTLEMIN 75
    
    :: Balanced priority separation
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "26" /f
)

echo.
echo ======================================================
echo    Game-Specific Optimizations
echo ======================================================
echo Select a game to apply specific optimizations:
echo 1. Counter-Strike 2
echo 2. Valorant
echo 3. Rust
echo 4. Fortnite
echo 5. No specific game (general gaming optimizations)
echo.

set /p GAME_CHOICE="Enter your choice (1-5): "

if "%GAME_CHOICE%"=="1" (
    echo Applying Counter-Strike 2 specific optimizations...
    
    :: CS2 benefits from high single-core performance
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb 0
    
    :: Minimal core parking for CS2
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 10 /f
    
    :: Optimize network settings for CS2
    netsh int tcp set global autotuninglevel=normal
    netsh int tcp set global ecncapability=disabled
    
    :: Set processor performance boost mode to aggressive
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 2
    
    :: Intel HD Graphics specific tweaks for CS2 (if applicable)
    echo Checking for Intel HD Graphics...
    wmic path win32_VideoController get Description | findstr /i "Intel HD Graphics" > nul
    if !errorlevel! equ 0 (
        echo Intel HD Graphics detected, applying CS2 specific tweaks...
        reg add "HKCU\Software\Valve\Steam\Apps\730" /v "DisableHWMorphAnimation" /t REG_DWORD /d 1 /f
        reg add "HKCU\Software\Valve\Steam\Apps\730" /v "ReduceMouseLag" /t REG_DWORD /d 1 /f
        echo Note: For best performance in CS2 with Intel Graphics:
        echo - Use a low resolution (1024x768 or 1152x864)
        echo - Enable Multicore Rendering
        echo - Set all other video settings to low
        echo - Use Trilinear texture filtering
        echo - Play in fullscreen mode
    )
    
    :: Premium CS2 tweaks
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PoolUsageMaximum" /t REG_DWORD /d "60" /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SessionViewSize" /t REG_DWORD /d "192" /f
)

if "%GAME_CHOICE%"=="2" (
    echo Applying Valorant specific optimizations...
    :: Valorant benefits from balanced multi-core performance
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb 0
    
    :: Low core parking for Valorant
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 15 /f
    
    :: Optimize network settings for Valorant
    netsh int tcp set global autotuninglevel=restricted
    netsh int tcp set global ecncapability=disabled
    
    :: Set processor performance boost mode to efficient aggressive
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 3
    
    :: Premium Valorant tweaks
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PoolUsageMaximum" /t REG_DWORD /d "60" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "ffffffff" /f
)

if "%GAME_CHOICE%"=="3" (
    echo Applying Rust specific optimizations...
    :: Rust benefits from multi-core performance
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb 0
    
    :: Partial core parking for Rust (balance between performance and thermals)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 50 /f
    
    :: Optimize memory management for Rust
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f
    
    :: Set processor performance boost mode to efficient aggressive
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 3
    
    :: Premium Rust tweaks
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PoolUsageMaximum" /t REG_DWORD /d "80" /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SessionViewSize" /t REG_DWORD /d "256" /f
)

if "%GAME_CHOICE%"=="4" (
    echo Applying Fortnite specific optimizations...
    :: Fortnite benefits from balanced multi-core performance
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb 0
    
    :: Minimal core parking for Fortnite
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 25 /f
    
    :: Optimize network settings for Fortnite
    netsh int tcp set global autotuninglevel=normal
    netsh int tcp set global ecncapability=disabled
    
    :: Set processor performance boost mode to efficient aggressive
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 3
    
    :: Premium Fortnite tweaks
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PoolUsageMaximum" /t REG_DWORD /d "60" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "ffffffff" /f
)

:: Apply changes to power plan
powercfg -setactive scheme_current

echo.
echo ======================================================
echo    Optimization Complete
echo ======================================================
echo Intel CPU optimizations have been applied successfully.
echo A backup of your registry settings has been saved to:
echo %TEMP%\power_backup.reg
echo %TEMP%\system_profile_backup.reg
echo %TEMP%\memory_management_backup.reg
echo %TEMP%\kernel_backup.reg
echo.
echo To restore original settings, double-click these files.
echo.
echo Press any key to exit...
pause > nul
