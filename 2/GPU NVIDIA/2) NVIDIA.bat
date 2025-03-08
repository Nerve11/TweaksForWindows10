@echo off
setlocal enabledelayedexpansion
color A
title Advanced NVIDIA GPU Series-Specific Optimization Tool

echo ======================================================
echo    Advanced NVIDIA GPU Series-Specific Optimization
echo ======================================================
echo.



:: Detect NVIDIA GPU and determine series
echo Detecting NVIDIA GPU series...
set "GPU_DETECTED=0"
set "SERIES="

for /f "tokens=*" %%i in ('wmic path win32_VideoController get Description ^| findstr /i "NVIDIA GeForce"') do (
    set GPU_NAME=%%i
    set GPU_DETECTED=1
    
    echo Detected: !GPU_NAME!
    
    echo !GPU_NAME! | findstr /i "1[0-9][0-9][0-9]" > nul
    if !errorlevel! equ 0 (
        set SERIES=10xx
        echo GPU Series: Pascal (10xx)
    )
    
    echo !GPU_NAME! | findstr /i "2[0-9][0-9][0-9]" > nul
    if !errorlevel! equ 0 (
        set SERIES=20xx
        echo GPU Series: Turing (20xx)
    )
    
    echo !GPU_NAME! | findstr /i "3[0-9][0-9][0-9]" > nul
    if !errorlevel! equ 0 (
        set SERIES=30xx
        echo GPU Series: Ampere (30xx)
    )
    
    echo !GPU_NAME! | findstr /i "4[0-9][0-9][0-9]" > nul
    if !errorlevel! equ 0 (
        set SERIES=40xx
        echo GPU Series: Ada Lovelace (40xx)
    )
)

if %GPU_DETECTED% equ 0 (
    echo No NVIDIA GPU detected. Optimization cannot proceed.
    goto :EOF
)

if "%SERIES%"=="" (
    echo Unable to determine GPU series. Applying generic optimizations...
    set SERIES=generic
)

echo.
echo Applying core optimizations for all NVIDIA GPUs...
echo.

:: Remove Telemetry for all GPUs
echo Removing telemetry components...
rd /s /q "C:\Program Files\NVIDIA Corporation\DisplayDriverRAS"
rd /s /q "C:\ProgramData\NVIDIA Corporation\DisplayDriverRAS"
reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v "SendTelemtryData" /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableGR535" /t REG_DWORD /d "0" /f
rmdir /s /q "C:\Windows\System32\drivers\NVIDIA Corporation"

:: Global optimizations for all GPUs
echo Applying global optimizations...
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d "20" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d "20" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PerfBoostMode" /t REG_DWORD /d "2" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f

echo.
echo Applying %SERIES%-specific optimizations...
echo.

:: Pascal series (10xx) optimizations
if "%SERIES%"=="10xx" (
    echo Applying Pascal architecture (10xx) specific optimizations...
    
    :: Enhanced memory clocks
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "MemoryTweak" /t REG_DWORD /d "3" /f
    
    :: Pascal-specific optimizations
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "PerfLevelSrc" /t REG_DWORD /d "3322" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "PowerMizerEnable" /t REG_DWORD /d "1" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "PowerMizerLevel" /t REG_DWORD /d "1" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "PowerMizerLevelAC" /t REG_DWORD /d "1" /f
    
    :: Special Pascal shader cache tweaks
    reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ShaderCache" /t REG_DWORD /d "1" /f
    reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ShaderCacheMaximumSize" /t REG_DWORD /d "4096" /f
    
    :: Pascal-specific memory timings
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global" /v "0x10de2204" /t REG_BINARY /d "3300000033000000" /f
    
    :: Disable P-State for Pascal
    for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
        for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
            for /f %%c in ('echo %%b ^| findstr "{"') do (
                Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
            )
        )
    )
)

:: Turing series (20xx) optimizations
if "%SERIES%"=="20xx" (
    echo Applying Turing architecture (20xx) specific optimizations...
    
    :: Turing-specific shader optimizations
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnableShaderPortabilityCache" /t REG_DWORD /d "1" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnablePreemption" /t REG_DWORD /d "0" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "DisablePreemptionOnS3S4" /t REG_DWORD /d "1" /f
    
    :: Turing-specific RTX optimizations
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnableRTXAcceleration" /t REG_DWORD /d "1" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnableGR535RTX" /t REG_DWORD /d "1" /f
    
    :: Shader cache optimization for Turing
    reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ShaderCache" /t REG_DWORD /d "1" /f
    reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ShaderCacheMaximumSize" /t REG_DWORD /d "5000" /f
    
    :: Turing-specific memory tweaks
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global" /v "PerfLevelSrc" /t REG_DWORD /d "8738" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global" /v "RmPVMRL" /t REG_DWORD /d "1" /f
    
    :: Special GDDR6 memory timing adjustments for 20xx series
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global" /v "0x10de1e84" /t REG_BINARY /d "2300000023000000" /f
    
    :: Disable Dynamic P-State for Turing
    for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
        for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
            for /f %%c in ('echo %%b ^| findstr "{"') do (
                Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
            )
        )
    )
)

:: Ampere series (30xx) optimizations
if "%SERIES%"=="30xx" (
    echo Applying Ampere architecture (30xx) specific optimizations...
    
    :: Ampere-specific PCIe 4.0 optimizations
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "GCGOPT_RoamingSettings_A" /t REG_BINARY /d "000000000001" /f
    
    :: Ampere-specific memory optimizations for GDDR6X
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global" /v "PerfLevelSrc" /t REG_DWORD /d "8738" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global" /v "RMPerfSetting" /t REG_DWORD /d "3" /f
    
    :: Enhanced shader cache for Ampere
    reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ShaderCache" /t REG_DWORD /d "1" /f
    reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ShaderCacheMaximumSize" /t REG_DWORD /d "6144" /f
    
    :: Resizable BAR optimization for Ampere
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnableResizableBAR" /t REG_DWORD /d "1" /f
    
    :: Ampere-specific RT and Tensor core optimizations
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnableRTXAcceleration" /t REG_DWORD /d "1" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnableDLSS" /t REG_DWORD /d "1" /f
    
    :: Ampere-specific threading optimization
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d "1" /f
)

:: Ada Lovelace series (40xx) optimizations
if "%SERIES%"=="40xx" (
    echo Applying Ada Lovelace architecture (40xx) specific optimizations...
    
    :: Ada Lovelace-specific PCIe 4.0/5.0 optimizations
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "GCGOPT_RoamingSettings_B" /t REG_BINARY /d "000000000002" /f
    
    :: Ada Lovelace-specific memory tweaks for GDDR6X
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global" /v "PerfLevelSrc" /t REG_DWORD /d "8738" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global" /v "RMPerfSetting" /t REG_DWORD /d "3" /f
    
    :: Enhanced shader cache for Ada Lovelace
    reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ShaderCache" /t REG_DWORD /d "1" /f
    reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ShaderCacheMaximumSize" /t REG_DWORD /d "8192" /f
    
    :: Resizable BAR optimization for Ada Lovelace
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnableResizableBAR" /t REG_DWORD /d "1" /f
    
    :: Ada-specific RT and Tensor core optimizations
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnableRTXAcceleration" /t REG_DWORD /d "1" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnableDLSS" /t REG_DWORD /d "1" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnableDLSS3" /t REG_DWORD /d "1" /f
    
    :: Ada Lovelace-specific VRAM optimization
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnableVramCompression" /t REG_DWORD /d "0" /f
    
    :: Premium Ada Lovelace frame generation optimizations
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnableFrameGeneration" /t REG_DWORD /d "1" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "FrameGenerationQuality" /t REG_DWORD /d "2" /f
    
    :: Advanced Ada threading optimization
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d "1" /f
)

:: Generic optimizations if series not detected
if "%SERIES%"=="generic" (
    echo Applying generic NVIDIA optimizations...
    
    :: General NVIDIA performance tweaks
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnableShaderPortabilityCache" /t REG_DWORD /d "1" /f
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnablePreemption" /t REG_DWORD /d "0" /f
    
    :: Generic shader cache optimization
    reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ShaderCache" /t REG_DWORD /d "1" /f
    reg.exe add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ShaderCacheMaximumSize" /t REG_DWORD /d "4096" /f
    
    :: Generic power optimization
    reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "DisplayPowerSaving" /t REG_DWORD /d "0" /f
    
    :: Disable Dynamic P-State generically
    for /f %%a in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do (
        for /f "tokens=3" %%b in ('reg query "HKLM\SYSTEM\ControlSet001\Enum\%%a" /v "Driver"') do (
            for /f %%c in ('echo %%b ^| findstr "{"') do (
                Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%c" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
            )
        )
    )
)

:: Common final optimizations for all GPUs
echo.
echo Applying final optimizations for all GPUs...

:: Disable HDCP and DRM
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableRID61684" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0002" /v "RMHdcpKeyglobZero" /t REG_DWORD /d "1" /f

:: Disable Power Saving
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "DisplayPowerSaving" /t REG_DWORD /d "0" /f

:: Clean shader caches
echo Cleaning shader caches for regeneration with optimized settings...
rd /s /q "%LOCALAPPDATA%\NVIDIA\DXCache"
rd /s /q "%LOCALAPPDATA%\NVIDIA\GLCache"

echo.
echo ======================================================
echo     Optimization Complete - System Restart Required
echo ======================================================
echo Applied %SERIES%-specific optimization tweaks.
echo GPU detected: %GPU_NAME%
echo.
echo Please restart your computer to activate all changes.
echo.

choice /c YN /m "Would you like to restart your computer now? (Y/N)"
if %errorlevel% equ 1 shutdown /r /t 10 /c "Restarting to apply NVIDIA optimizations"

exit