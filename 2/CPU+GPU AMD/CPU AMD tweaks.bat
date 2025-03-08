@echo off
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
echo    Advanced AMD CPU Optimization Tool
echo ======================================================
echo.

:: Detect AMD CPU and determine architecture
echo Detecting AMD CPU architecture...
set "CPU_DETECTED=0"
set "ARCHITECTURE="
set "CPU_NAME="

for /f "tokens=*" %%i in ('wmic cpu get Name ^| findstr /i "AMD"') do (
    set CPU_NAME=%%i
    set CPU_DETECTED=1
    
    echo Detected: !CPU_NAME!
    
    echo !CPU_NAME! | findstr /i "Ryzen 1" > nul
    if !errorlevel! equ 0 (
        set ARCHITECTURE=ZEN1
        echo CPU Architecture: Zen 1 (Ryzen 1000 Series)
    )
    
    echo !CPU_NAME! | findstr /i "Ryzen 2" > nul
    if !errorlevel! equ 0 (
        set ARCHITECTURE=ZEN+
        echo CPU Architecture: Zen+ (Ryzen 2000 Series)
    )
    
    echo !CPU_NAME! | findstr /i "Ryzen 3" > nul
    if !errorlevel! equ 0 (
        set ARCHITECTURE=ZEN2
        echo CPU Architecture: Zen 2 (Ryzen 3000 Series)
    )
    
    echo !CPU_NAME! | findstr /i "Ryzen 5[0-9][0-9][0-9]" > nul
    if !errorlevel! equ 0 (
        set ARCHITECTURE=ZEN3
        echo CPU Architecture: Zen 3 (Ryzen 5000 Series)
    )
    
    echo !CPU_NAME! | findstr /i "Ryzen 7[0-9][0-9][0-9]" > nul
    if !errorlevel! equ 0 (
        set ARCHITECTURE=ZEN4
        echo CPU Architecture: Zen 4 (Ryzen 7000 Series)
    )
    
    echo !CPU_NAME! | findstr /i "Threadripper" > nul
    if !errorlevel! equ 0 (
        echo CPU Type: Threadripper (HEDT)
    )
)

if "%CPU_DETECTED%"=="0" (
    echo No AMD CPU detected. This script is designed for AMD processors only.
    pause
    exit /b 1
)

if "%ARCHITECTURE%"=="" (
    echo Unable to determine CPU architecture. Applying generic optimizations.
    set ARCHITECTURE=GENERIC
)

echo.
echo ======================================================
echo    Select Optimization Profile
echo ======================================================
echo 1. Balanced (Recommended)
echo 2. Gaming Focused
echo 3. Power Efficiency
echo 4. Maximum Performance
echo 5. Game-Specific Optimizations
echo.

set /p PROFILE_CHOICE="Enter your choice (1-5): "

if "%PROFILE_CHOICE%"=="5" (
    echo.
    echo ======================================================
    echo    Select Game for Specific Optimizations
    echo ======================================================
    echo 1. CS2
    echo 2. Valorant
    echo 3. Rust
    echo 4. Fortnite
    echo.
    
    set /p GAME_CHOICE="Enter your choice (1-4): "
)

echo.
echo Applying CPU optimizations for %ARCHITECTURE% architecture...
echo.

:: Create registry backup
echo Creating registry backup...
reg export "HKLM\SYSTEM\CurrentControlSet\Control\Power" "%TEMP%\power_backup.reg" /y
reg export "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}" "%TEMP%\gpu_backup.reg" /y
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "%TEMP%\system_profile_backup.reg" /y

:: Apply common optimizations for all AMD CPUs
echo Applying common AMD CPU optimizations...

:: Power plan optimizations
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 88888888-8888-8888-8888-888888888888
powercfg -changename 88888888-8888-8888-8888-888888888888 "AMD Optimized Performance" "Custom power plan optimized for AMD CPUs"
powercfg -setactive 88888888-8888-8888-8888-888888888888

:: System profile optimizations
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f

:: Apply architecture-specific optimizations
if "%ARCHITECTURE%"=="ZEN1" (
    echo Applying Zen 1 specific optimizations...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoreParkingMinCores" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoreParkingMaxCores" /t REG_DWORD /d 100 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 100 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d 0 /f
)

if "%ARCHITECTURE%"=="ZEN+" (
    echo Applying Zen+ specific optimizations...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoreParkingMinCores" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoreParkingMaxCores" /t REG_DWORD /d 100 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 100 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d 0 /f
)

if "%ARCHITECTURE%"=="ZEN2" (
    echo Applying Zen 2 specific optimizations...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoreParkingMinCores" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoreParkingMaxCores" /t REG_DWORD /d 100 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 100 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d 0 /f
    
    :: Zen 2 specific - Preferred cores optimization
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb" /v "Attributes" /t REG_DWORD /d 2 /f
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb 1
)

if "%ARCHITECTURE%"=="ZEN3" (
    echo Applying Zen 3 specific optimizations...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoreParkingMinCores" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoreParkingMaxCores" /t REG_DWORD /d 100 /f
    
    :: Zen 3 specific - Preferred cores and cache optimization
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb" /v "Attributes" /t REG_DWORD /d 2 /f
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb 1
    
    :: Zen 3 specific - CPPC2 (Collaborative Processor Performance Control 2)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\4e942a8f-d43e-4280-a174-55a4e440f4bc" /v "Attributes" /t REG_DWORD /d 2 /f
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 4e942a8f-d43e-4280-a174-55a4e440f4bc 1
)

if "%ARCHITECTURE%"=="ZEN4" (
    echo Applying Zen 4 specific optimizations...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoreParkingMinCores" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoreParkingMaxCores" /t REG_DWORD /d 100 /f
    
    :: Zen 4 specific - Preferred cores and cache optimization
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb" /v "Attributes" /t REG_DWORD /d 2 /f
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb 1
    
    :: Zen 4 specific - CPPC2 (Collaborative Processor Performance Control 2)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\4e942a8f-d43e-4280-a174-55a4e440f4bc" /v "Attributes" /t REG_DWORD /d 2 /f
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 4e942a8f-d43e-4280-a174-55a4e440f4bc 1
    
    :: Zen 4 specific - Enhanced power efficiency
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\36687f9e-e3a5-4dbf-b1dc-15eb381c6863" /v "Attributes" /t REG_DWORD /d 2 /f
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 36687f9e-e3a5-4dbf-b1dc-15eb381c6863 0
)

:: Apply profile-specific optimizations
if "%PROFILE_CHOICE%"=="1" (
    echo Applying Balanced profile optimizations...
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 50
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 50
)

if "%PROFILE_CHOICE%"=="2" (
    echo Applying Gaming Focused profile optimizations...
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 100
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100
    
    :: Disable core parking for gaming
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 0 /f
    
    :: Optimize for latency
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f
)

if "%PROFILE_CHOICE%"=="3" (
    echo Applying Power Efficiency profile optimizations...
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 30
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 30
    
    :: Enable core parking for power efficiency
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 100 /f
)

if "%PROFILE_CHOICE%"=="4" (
    echo Applying Maximum Performance profile optimizations...
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 100
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100
    
    :: Disable core parking completely
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 0 /f
    
    :: Set processor performance boost mode to aggressive
    powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 2
)

:: Apply game-specific optimizations if selected
if "%PROFILE_CHOICE%"=="5" (
    if "%GAME_CHOICE%"=="1" (
        echo Applying CS2 specific optimizations...
        :: CS2 prefers strong single-core performance
        powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb 1
        
        :: Disable core parking for CS2
        reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 0 /f
        
        :: Optimize network settings for CS2
        netsh int tcp set global autotuninglevel=normal
        netsh int tcp set global ecncapability=disabled
        
        :: Set processor performance boost mode to aggressive
        powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 2
    )
    
    if "%GAME_CHOICE%"=="2" (
        echo Applying Valorant specific optimizations...
        :: Valorant prefers strong single-core performance
        powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb 1
        
        :: Disable core parking for Valorant
        reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 0 /f
        
        :: Optimize network settings for Valorant
        netsh int tcp set global autotuninglevel=normal
        netsh int tcp set global ecncapability=disabled
        
        :: Set processor performance boost mode to aggressive
        powercfg -setacvalueindex 88888888-8888-8888-8888-888888888888 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 2
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
    )
)

:: Apply changes to power plan
powercfg -setactive scheme_current

echo.
echo ======================================================
echo    Optimization Complete
echo ======================================================
echo AMD CPU optimizations have been applied successfully.
echo A backup of your registry settings has been saved to:
echo %TEMP%\power_backup.reg
echo %TEMP%\gpu_backup.reg
echo %TEMP%\system_profile_backup.reg
echo.
echo To restore original settings, double-click these files.
echo.
echo Press any key to exit...
pause > nul
